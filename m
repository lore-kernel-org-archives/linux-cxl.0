Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793154117;
	b=I7Y/actucuGJMpKll36UERxTA+mGB5/Krrtlopv6/OqY0JE1hgUKKZXtDGVlW9pGyv8Q
	 NGyKJROXQMJV82sFGgPWe20x+uBswwfcNl2E7R9JvHTTuEGNi5eRFq2VQGtSQ1a5T/Lry
	 vQh9xOkjwoeB+NDBlVsr7XiZIUy3lgU7eFaOwGJeLUEwpB0WzGQtrVyXuAWNU0Y7kJKt+
	 oGpUxn6LWI3Qcr21ZoELUd1PI6vrV72Omfma9tMGqxGZGcLfhDeR83SaQOaTRVvP/lkda
	 Zrl72XJU1DhxU2hUITEjLvNvUlzBvNHZL18Lxq9b/aR+yfVc2NyIpI82VU2ymyu54cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793154117;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=07fdz0+VNa8IX3wBAkhzwCQegklKd+ur4DUhHBeZ5no=;
	b=uNwPSfuKUhrDlICXodUdONiLbkoIr97hUaCaSeNCMxW3IfRLJe8PcdYgeeh34p6clP7X
	 4BTDQp9ftE/Ib1WdnSadrqid5jV1Eo2RWAU614sM0SBHibY04RjHowiHiDV7E899F9A6Q
	 NWxROfYtNVWDqmifUz5KOZ/B2Msq3eYPQ0R1YY1vy6mcfyXENww2xYxYSTOQ5nByKG8Bu
	 DrEjosKkRGpQW19fdZ6RYUY9ztOLgGb7kuVQHbsaSgjFTawGAhpb/Oi6TwBjfnHXchDnx
	 X9peky4vZu6BdQoQ2M5jqhmpUXrgpRsVd9ZCf7DQwQIQ33CF7938z9e8UdLswRnRsfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j0x4GeoU;
	arc=none smtp.remote-ip=115.124.30.99
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4B606A327;
	Wed, 28 Oct 2026 02:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54A4B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j0x4GeoU
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793154114; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=07fdz0+VNa8IX3wBAkhzwCQegklKd+ur4DUhHBeZ5no=;
	b=j0x4GeoUe0wwkES8HlsAwyzYQckoTQ2VklVBNj6W+ki/N/zxaUSZYrD9074wr06Umbz1Cnna/Xrfi285HEvQ+fzBPQfm/ClDylUvb2cdfrsZ3vYw8HJIIG4SHKFX+VOfZZYVrM5AtHSNDR4cgkVr6QzQKE49Q5+0J+oKPqHw6hI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XDfO8OP_1793154112;
Received: from 30.178.69.77(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDfO8OP_1793154112 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 10:21:53 +0800
Message-ID: <b42c1849-8998-40d1-a433-2b4077374074@linux.alibaba.com>
Date: Wed, 28 Oct 2026 10:21:51 +0800
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
Subject: Re: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in if
 conditions
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Andy Whitcroft <apw@canonical.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260924033923.4140210-1-kanie@linux.alibaba.com>
 <6595ac9f640a3796f34f58ba6d97d61bc0c07558.camel@perches.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <6595ac9f640a3796f34f58ba6d97d61bc0c07558.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joe,
  Could you please apply this patch to 7.4?

Best Regards,
Guixin Liu

在 2026/9/25 01:09, Joe Perches 写道:
> On Thu, 2026-09-24 at 11:39 +0800, Guixin Liu wrote:
>> ACQUIRE_ERR() and its wrappers, PM_RUNTIME_ACQUIRE_ERR() and
>> IIO_DEV_ACQUIRE_FAILED(), report whether a conditional cleanup.h guard
>> was acquired, and drivers consume the result directly in an if
>> condition:
>>
>> 	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
>> 		return rc;
>>
>> That combined form is the established style at the 49 in-tree call
>> sites under drivers/cxl and drivers/pci/tsm.c, so ASSIGN_IN_IF fires
>> there only as a false positive, and every patch touching those lines
>> carries noise that reviewers have to wave off manually.
>>
>> Skip the check only when every assignment in the condition assigns the
>> result of such a call, matched by the *_ACQUIRE_ERR() /
>> *_ACQUIRE_FAILED() naming convention of its wrappers. Plain
>> assignments, mixed conditions and near-miss identifiers still get
>> flagged.
>>
>> Suggested-by: Alison Schofield <[alison.schofield@intel.com](mailto:alison.schofield@intel.com)>
>> Cc: [linux-cxl@vger.kernel.org](mailto:linux-cxl@vger.kernel.org)
>> Assisted-by: LLM
>> Signed-off-by: Guixin Liu <[kanie@linux.alibaba.com](mailto:kanie@linux.alibaba.com)>
> Acked-by: Joe Perches <joe@perches.com>
>
>> ---
>> Changes since v1 [1]:
>>
>> - Check each assignment in the condition instead of the condition as a
>>   whole, so a mixed condition such as
>>   "if ((rc = regular_function()) || (ret = ACQUIRE_ERR(...)))" keeps
>>   getting flagged (Alison Schofield).
>> - Match the assigned-to expression with $Lval, as Joe Perches
>>   suggested on Alison's earlier attempt at this exception [2].
>> - Cc linux-cxl, where most users of this form live.
>>
>> Two deviations from [2]: the assigned expression capture excludes '=',
>> so an '==' comparison in a mixed condition is not mistaken for a bad
>> assignment, and the check requires an assignment the $Lval match can
>> see, so compound assignments like '+=', which it cannot see, are not
>> silently allowed.
>>
>> Testing: ran checkpatch on a test file with the allowed forms (bare
>> macro and both wrappers, member and array element lhs, multiple
>> ACQUIRE family assignments in one condition, an '==' comparison
>> alongside, no spaces around '=') and with 14 cases that must still
>> trigger (plain assignments, near-miss identifiers, arithmetic on the
>> call result, ACQUIRE_ERR in a comment, indirect assignment, mixed
>> conditions in both orders). All allowed forms pass, all 14 still
>> trigger. The 49 in-tree call sites under drivers/cxl and
>> drivers/pci/tsm.c no longer report ASSIGN_IN_IF, and checkpatch output
>> is unchanged for fs/namei.c, kernel/sched/core.c, mm/vmscan.c and
>> net/core/dev.c.
>>
>> [1] [https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alibaba.com/](https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alibaba.com/)
>> [2] [https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/](https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/)
>> ---
>>  scripts/checkpatch.pl | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 8a7787d228a6..eee06ac6737f 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -5777,7 +5777,21 @@ sub process {
>>  			my ($s, $c) = ($stat, $cond);
>>  			my $fixed_assign_in_if = 0;
>>  
>> +			# ACQUIRE_ERR() and its wrappers, e.g. PM_RUNTIME_ACQUIRE_ERR()
>> +			# and IIO_DEV_ACQUIRE_FAILED(), are meant to be evaluated in an
>> +			# if condition, with the error assigned in the condition:
>> +			#	if ((rc = ACQUIRE_ERR(name, &lock)))
>> +			# Allow that only when every assignment in the condition assigns
>> +			# the result of such a call, so that a mixed condition keeps
>> +			# getting flagged:
>> +			#	if ((rc = regular_function()) || (ret = ACQUIRE_ERR(name, &lock)))
>> +			my $assign_in_if = 0;
>>  			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
>> +				my $has_assignment = $c =~ /\b$Lval\s*=\s*[^,)&|=]+/;
>> +				my $has_other_assignment = $c =~ /\b$Lval\s*=\s*(?!\s*\w*ACQUIRE_(?:ERR|FAILED)\s*\()[^,)&|=]+/;
>> +				$assign_in_if = !$has_assignment || $has_other_assignment;
>> +			}
>> +			if ($assign_in_if) {
>>  				if (ERROR("ASSIGN_IN_IF",
>>  					  "do not use assignment in if condition\n" . $herecurr) &&
>>  				    $fix && $perl_version_ok) {
>>

