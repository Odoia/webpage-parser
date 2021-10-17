RSpec.describe WebpageVisit do
  context 'when given a correct log' do
    let(:path) { './spec/logs/correct_log.log' }
    let(:subject_with_correct_log) do
      ARGV.replace [path]
      subject.do_hash_with_file
    end

    context 'when has all values grouped by webpage' do
      it 'must return a total webpages' do
        hash = subject_with_correct_log
        expect(hash.count).to eq 6
      end

      it 'must return all data count is 500' do
        total_webpages = 0
        hash = subject_with_correct_log
        result = subject.total_visits(hash)
        result.each { |c| total_webpages += c[1] }
        expect(total_webpages).to eq 500
      end

      it 'must return all unique data count is 135' do
        total_webpages = 0
        hash = subject_with_correct_log
        result = subject.total_unique_visits(hash)
        result.each { |c| total_webpages += c[1] }
        expect(total_webpages).to eq 135
      end
    end

    context 'when givens a printed result' do
      context 'when use a unique method' do
        it 'must return correct result to unique views' do
          hash = subject_with_correct_log
          unique_hash = subject.total_unique_visits(hash)
          result = subject.print_result(unique_hash, type: 2).first
          expect(result).to eq '-> /index 23 unique views'
          expect(result).to include '23'
        end
      end

      context 'when use a unique method' do
        it 'must return correct result to unique views' do
          hash = subject_with_correct_log
          unique_hash = subject.total_visits(hash)
          result = subject.print_result(unique_hash).first
          expect(result).to eq '-> /about/2 90 views'
          expect(result).to include '90'
        end
      end
    end
  end

  context 'when given a log containing incorrect data' do
    let(:path) { './spec/logs/log_with_incorect_log.log' }
    let(:subject_with_incorrect_log) do
      ARGV.replace [path]
      subject.do_hash_with_file
    end

    context 'when show a total visit' do
      it 'should not show incorrect logs' do
        hash = subject_with_incorrect_log
        unique_hash = subject.total_visits(hash)
        result = subject.print_result(unique_hash)
        expect(result).to_not include '/contact184.123.665.067 /about/2444.701.448.104 
                 /index444.701.448.104 /about061.945.150.735 /home235.313.352.950'
      end
    end

    context 'when dont pass an archive' do
      let(:path) {}
      it 'should return nil' do
        subject_with_incorrect_log
        expect(subject.call).to be_nil
      end
    end
  end
end

