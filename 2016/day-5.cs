void Main()
{
	var outputs = new char[8] {'x', 'x', 'x', 'x', 'x', 'x', 'x', 'x'};
	
	var str = "cxdnnyjw";

	var pws = Counter()
		.Select(i => HashAttempt(str, i))
		.Where(hash => hash.StartsWith("00000"))
		.Select(hash => hash[5])
		.Take(8);
		
	// part 1
	//Observable.ToObservable(pws).Dump();
	
	var hashes = Counter()
		.Select(i => HashAttempt(str, i))
		.Where(hash => hash.StartsWith("00000"))
		.GetEnumerator();
	
	// part 2
	while (outputs.Any(i => i == 'x'))
	{
		hashes.MoveNext();
		var hash = hashes.Current;
		
		int idx = hash[5] - '0';
		
		if (idx < 8 && outputs[idx] == 'x') outputs[idx] = hash[6];
		
		String.Join("", outputs).Dump(hash);
	}
}

MD5 md5 = MD5.Create();

IEnumerable<long> Counter()
{
	long i = 0;
	while(true) yield return i++;
}

string HashAttempt(string str, long i)
{
	var hashbytes = md5.ComputeHash(Encoding.UTF8.GetBytes(str + i));
	return String.Join("", hashbytes.Select(b => b.ToString("X2")));
}
