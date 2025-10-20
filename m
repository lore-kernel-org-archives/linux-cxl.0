Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F42FB993
	for <linux-cxl@vger.kernel.org>; Mon, 20 Oct 2025 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958889; cv=none; b=kpcyPHbRu9l3oCE2VjD6XpO8pJ2Q6ULmHlc8huWi+DcUHqcBx6WSfhsfJPxjJKpL+fjgEU5FBjz8JYRtw0p33H0Am/J9XTrXko3X2CqAn4zNEdmPInzq09KWiMkyxoJo1Sp+WGmFy1RAONeSF3+LMI+Y+nvt3DUnkp5h5ClxQLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958889; c=relaxed/simple;
	bh=yu+90TndiBqCq4JNXbrEh4sEW4TWRPZfANLCmUfUeGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bXqDM8L74MKdXkvfqaBPtvYIQAvR6aoJAy5U6KDnqX4J1EbdJ/jc7Elf3jxwwoNSmzbpq5Am12Ck+BIZDUv6vBN6tUo2xCRM4ed8XV++x5uuuaf9N10b0aWh2EVWCwHe/ksFct+8f4PC2Rq7xzw8W+c9VxrAgeviIOkByZ1hbek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QPIRNEDC; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QPIRNEDC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760958877; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=jnGKDSquHXSRwh0WaA1gWr2tLJKUI7/5cImWo821uA0=;
	b=QPIRNEDC78N5iR1kyjUPxXrI50GmfsZ4LNMkwEuMezbQDadVHO4I5Xni5pm6AtxXnCcl8iFOm3QeqRw6q+I4EQ9Omt04KxHUwMgrD5DZuX4LIhYBJi25EnzJ1qT8Fac16NTI+G/L9kQd6fl7v6lJiCrAtp6xaTbvn97HoIUY8R0=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wqb1FJw_1760958876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 19:14:37 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: <dan.j.williams@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  <dave.jiang@intel.com>,
  <alison.schofield@intel.com>,  <ira.weiny@intel.com>,
  <vishal.l.verma@intel.com>,  <seven.yi.lee@gmail.com>,
  <hch@infradead.org>,  <a.manzanares@samsung.com>,  <fan.ni@samsung.com>,
  <linux-cxl@vger.kernel.org>
Subject: Re: Deep flush support for CXL pmem?
In-Reply-To: <68f294af24168_2a201001c@dwillia2-mobl4.notmuch> (dan
	j. williams's message of "Fri, 17 Oct 2025 12:10:39 -0700")
References: <87zf9qf46z.fsf@DESKTOP-5N7EMDA>
	<68f294af24168_2a201001c@dwillia2-mobl4.notmuch>
Date: Mon, 20 Oct 2025 19:14:34 +0800
Message-ID: <87jz0pddut.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Dan,

<dan.j.williams@intel.com> writes:

> Huang, Ying wrote:
>> Hi, All,
>> 
>> When reading the documentation of PMDK (https://github.com/pmem/pmdk), I
>> found that deep flush is used for data loss recovery in addition to GPF.
>> With that, we can identify that a file isn't affected by the GPF failure
>> because it wasn't opened during the GPF failure.
>> 
>> However, IIUC, the Linux kernel doesn't support deep flush (via
>> nvdimm_flush()) for CXL pmem at least for now.  For NVDIMM, we have WPQ,
>> but it appears that we don't have that for CXL.  Is deep flush for CXL
>> defined in some spec?
>
> No, and I think a dynamic "deep flush" mechanism is a mistake that CXL
> should not pursue. (personal opinion, not necessarily opinion of
> $employer)
>
> "All storage is a lie" applies here in that all a deep flush mechanism
> does is maybe reduce the occurrence of dirty-shutdown failures. It can
> not guarantee that some other event causes the write to be dropped.
>
> CXL does have a Global Persistence Flush mechanism that fires as the
> system is dying, but it is not something that can be triggered at run
> time.
>
> So, either the system has the reserve energy to make sure that all
> globally visible writes make it to persistent storage or it does not. If
> it does not then it had better arrange for those failures to be flagged
> via a dirty shutdown mechanism.
>
> If a platform fires dirty-shutdown events at a significantly higher rate
> than say the capacitor-protected write-cache on an SSD, then that feels
> like an "improve the hardware" problem, not a "teach the software to
> chase writes with a deep flush and hope it helps" problem.
>
> See discussions like this for the last time mapping pmem deep flush was
> attempted to be mapped to storage semantics like FUA (Force Unit
> Access):
>
> http://lore.kernel.org/YtefnyIvY9OdrVU5@infradead.org

Thanks a lot for the detailed explanation and reference to the previous
discussion.  It's very helpful.

As you said, in fact, we cannot trust "deep flush" either.  So, it
provides little value on top of the dirty shutdown count.

---
Best Regards,
Huang, Ying
