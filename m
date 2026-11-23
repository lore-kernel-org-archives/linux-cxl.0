Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795418074;
	b=cEhZ0i+EMbsGKNTJklGTRLEKJvUVevPgG+Z/z6f5JVptF26EPFKj9t5sQL/1kiYAOm3c
	 In5jrRt5ckaPUwnN76Y/5YBKIGh5931MvuNa1ntVXSr5K9B1RM/mAPEdqmwTBG1drIsq9
	 q1veOHZfmc08nMQRJvCD/k7IuOqZQP0FC87lFCw6Zj4FRcr/Xiqxr8lTdrtrDEt3iqe75
	 0AYIuTh7FEUGDOu89WYT9TU7Zap4tt0y5jZwa+wpSCul5HTwr5bTZwM6ckWY56tKHhC89
	 qmbM4VZqch7PPpmkKnrdOf3A6d0DuR0TdvI6jPmhk62jn8zv/9hoJj7/sLarqNuONIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418074;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=P/zQg7tpsjTGTAH9tHHBKpLs9Ukp8tVrYLDerfWrYsI=;
	b=Qo8hCpFdwEB+VN9rh7gQoqg+BxOb3uTY5DKrGOz+ViDq86XBC999IlgO/WkU0rXoW2qE
	 //WHBbmbF0uoYUCJqZTRhQm6w0W0SvEh7++ZoYxRa2eFcj7M7qDM0qXysk9Md6Kd4RclF
	 4SIi1j5oT/1ofVMHQproV2drzC79/9zbEGLLfnhpo5L5TytfA7folEWcaJ/66cS0QEoSy
	 tzkLOuMGmSdA4OLkaXE2R+rpiCrTVe4DIcj+diH8ljIPvGkJBYVBD4DA4JHmkpCG1ic1b
	 6HgadrdxGm+VpKmhExtExEADceRBsYYIyHhwNTKRhvkhx2WphupwbMTy4dbxqrtRbrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=H43EoM5K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.92
Received: from sender6-pp-o92.zoho.com (sender6-pp-o92.zoho.com [165.173.180.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA6606A31A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Nov 2026 07:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92FA6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=H43EoM5K
ARC-Seal: i=1; a=rsa-sha256; t=1795418059; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dc2VsM1bPp0RcDmuipuC9QtYWDjKkUOOPdjoIn7c2jyc5lPM/D8snQ+pypJ3gMQ/sd4OO7j96Z/PX6YReltzDF0B0ughSHLDCoArGb20Gt84BRs0YdQ94Y5wO+N0dyB87TYrJeOQuJqWdUeCIXlsTZtA9/ZZm58RUEH+eJsbQgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795418059; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P/zQg7tpsjTGTAH9tHHBKpLs9Ukp8tVrYLDerfWrYsI=; 
	b=jdvP3p9Xtqip4WpAD5TTwQTj0hpGFH64WhZfkf4pR/SqyuJMOJ/1gpqKAvzYWW/Whsu79xRy3tP7K8vANVPmbiPMXnq1xLV/GwcrI2zWMhbueksrEYh/Pra8Zqq+OgO0MK668oforbtGzWOI4SH9Bqg5ZmC/NQ1ooi83dYVjpVs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=H43EoM5KG4EFZUC4KlP5elR4LuCMWvSevDOo6/ITaKwYiDw7dcPt3Pbe2ZKh2q+h9DMr61+sFjyMRo9l81giimyghVKzJq5bbQxjQe5fcHwbgisEjw4D5qV1hakSS1VDS6QMACXKQQv2mgyxp8LFxkWvNXoxIJ+SfdDp0CzRddI=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=P/zQg7tpsjTGTAH9tHHBKpLs9Ukp8tVrYLDerfWrYsI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795418056699217.7770071191337;
	Sun, 22 Nov 2026 23:14:16 -0800 (PST)
Message-ID: <991536fb-baaa-4855-bba6-a60ab44f6879@zohomail.com>
Date: Mon, 23 Nov 2026 15:14:13 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH 0/2] Fix cxl-translate.sh test failures
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
References: <20261120071415.29279-1-ming.li@zohomail.com>
 <awD5YKbS1R6xGW4n@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <awD5YKbS1R6xGW4n@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu080112277a0f3b2514810a6ad831e84700009ac8e83ae725cd5afc2482b2f5494dc9fd37a0113ba76150c6:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/21 09:52, Alison Schofield 写道:
> On Fri, Nov 20, 2026 at 03:14:13PM +0800, Li Ming wrote:
>> When running cxl-translate.sh repeatedly in my test environment, I can
>> occasionally reproduce test failures. The failure point varies from run
>> to run, but the root cause is the same: the test is unable to find the
>> expected kernel log messages.
>>
>> Investigation shows that the expected messages are actually present in
>> dmesg. However, immediately after "modprobe cxl_translate" completes,
>> "journalctl --reverse --dmesg" may not yet have received all kernel
>> messages emitted during cxl_translate_init(). This timing gap causes the
>> test script to miss expected log entries and report false failures.
> Hi Ming,
>
> Good catch! Can you fold patch 2 into patch 1. Both address the same delay
> between modprobe returning and the results becoming visible in the journal.
> Patch 1 can still fail if journald has recorded only the first PASS or FAIL
> line, and patch 2 supplies the completion marker that makes the polling work.
>
> -- Alison

Hi Alison,


Thanks for your review.

I have read all your comments, will send out v2 based on your suggestions.


Ming

>
>> This patchset addresses the issue in two steps:
>> Patch 1 adds a helper that retries fetching the expected kernel log
>> message for up to 5 seconds. This mitigates failures caused by temporary
>> delays in log visibility through journalctl.
>>
>> Patch 2 updates the result checking logic for test cases that use a
>> specific translation table. Instead of treating the appearance of a "CXL
>> Translate Test.*PASS|FAIL" message as an indication that the test has
>> finished, it waits for the "CXL translate test completed" message.
>> During test execution, multiple "CXL Translate Test.*PASS|FAIL" messages
>> may be emitted as individual checks complete, so the presence of such
>> messages does not necessarily mean that the entire test has finished.
>> The completion message provides a reliable indication that all test
>> cases have completed and all results are available for verification.
>>
>> Li Ming (2):
>>    test/cxl-translate.sh: Wait expected log before checking result
>>    test/cxl-translate.sh: Wait for test completion before checking result
>>
>>   test/cxl-translate.sh | 23 +++++++++++++++++++++--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.43.0
>>
>>
