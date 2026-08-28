Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A403AA1BF
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903243; cv=none; b=szjrY51AXE4dfvJOKxhFMjgCxlxMENL0sG/XAxwekmsCm5ySnnHhUsCr9uWJGRjBj/WehE/EVIiYai2Oe6gEn7IGXIBwcr/6Dn11GvXCENPik/CYJZj4qGRXq4b6foD3lCTT1AGmfGtWKhqyA18NF0iUc7OldYi7aWPOH5ClMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903243; c=relaxed/simple;
	bh=NwgI/KoS6AzBC3nZAyJidBZ+GshtzAOWB4PSQKXI9a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERo9kJGdpeLoLEpL89eea9QvcG25np2TaEslzvH33LrQIhbjw1Yb+pw7AY6E85jKMBFyudNKkKMq+J2IasmIhateSCAiF6nD2nPwDJjjznozPRNYtghc+xcOMDVVHAouCJPuPkt8kMuBrJ0NyJjTnPt6d1Gl202U99oz3Fqhexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v/O0+9g+; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v/O0+9g+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787903236; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ymbPZnid4UeGBYzB1gimulWUJ7Ta+0+obpFtB/Tbm2A=;
	b=v/O0+9g+nJhyfVyAToUYjgFGsfRrsYc5SteZON0P4rjLOxrAaW2x38DaZU/+/agpnvv6DQzFA7iiD8A7qDkfYmyfIY7eWrejUkrs4YunMLCe4AAXVRzlOSeSmMh0TWG26LHTejk6eU+ez/CZYmT55iEn3vaooFtOzJUpnvCBt2M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9lrKN3_1787903234;
Received: from 30.178.68.240(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9lrKN3_1787903234 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 15:47:15 +0800
Message-ID: <77fd095e-ca67-4459-b5e6-319b6226c75d@linux.alibaba.com>
Date: Fri, 28 Aug 2026 15:47:14 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/core: Fix dport use-after-free via the einj_inject
 debugfs file
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
References: <20260812060943.56246-1-kanie@linux.alibaba.com>
 <apDXSzSZVcjQ027J@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <apDXSzSZVcjQ027J@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/28 08:33, Alison Schofield 写道:
> On Wed, Aug 12, 2026 at 02:09:43PM +0800, Guixin Liu wrote:
>
>
> Hi Guixin Liu,
>
> Skipping ahead to the changelog, you write
>> - rewrite the commit message to describe the behaviour rather than narrate
>>    the code change (Alison Schofield)
> I went back and looked at v1, and somehow the commit message got
> substantially longer and harder to understand in response to my request
> to make it clearer. V1 was actually closer. It needed to be simplified,
> not expanded.
>
> This reads more like a forensic report of everything learned while
> investigating the bug than a commit message explaining why this change
> is needed. It is dense material, far too detailed to the point of
> clarifying nothing.
>
>
>
>> cxl_debugfs_create_dport_dir() publishes a debugfs directory containing an
>> "einj_inject" file whose i_private is the 'struct cxl_dport', then discards
>> the returned dentry and registers nothing to remove it. The other per-dport
>> facility set up next to it in __devm_cxl_add_dport(),
>> devm_cxl_dport_ras_setup(), binds its resources to dport_to_host(dport) so
>> that they go away with the dport. The debugfs directory has no such owner:
>> it lives until cxl_core is unloaded and cxl_core_exit() tears down the
>> whole cxl/ tree.
> Most of the above is unnecessary. The comparison with devm_cxl_dport_ras_setup()
> adds nothing to the description of the bug. Neither does walking through the
> eventual module cleanup.
>
> The important background is simply that einj_inject retains a pointer
> to the cxl_dport, but its lifetime is not tied to the dport.
>
>> The dport itself is freed much earlier. free_dport() is registered in the
>> dport's devres group, so the dport is freed when the host device is
>> unbound, which is an ordinary sysfs operation on the host bridge port or
>> the ACPI0017 root, not a module-teardown-only path. After that unbind the
>> einj_inject file is still there, and a write to it calls cxl_einj_inject()
>> on freed memory, reading dport->rch and dport->dport_dev and passing them
>> to the EINJ code.
>
> Above, the important point is buried at the end. Unbinding the host frees
> the dport but leaves einj_inject behind, so writing the file can
> dereference the freed dport.
>
> That is the issue and impact. The devres mechanics, specific devices that
> can be unbound, and individual fields subsequently accessed do not make
> that clearer.
>
>
>> Re-binding the topology does not recover either. The stale directory keeps
>> the dport device's name, so the second creation finds the name in use,
>> debugfs setup fails, and error injection is silently unavailable for that
>> dport for the remaining lifetime of the module.
>
> Above is useful as a secondary impact, but can be one sentence: the stale
> directory also prevents the debugfs directory from being recreated on
> rebind.
>
>
>> Keep the dentry and remove the directory from a devm action on the dport's
>> host device. The action is registered after free_dport() within the same
>> devres group, so release ordering runs it before the dport is freed. Its
>> registration failure is deliberately not propagated, following
>> devm_cxl_dport_ras_setup(): a missing debugfs directory is not a
>> functional failure of the dport, and on that path
>> devm_add_action_or_reset() has already removed the directory itself, so
>> there is no dangling node left and nothing to gain from failing the dport
>> addition.
> This is implementation narration. The resolution is simply to remove
> the per-dport debugfs directory when the dport host is released. If
> there is a subtle implementation choice that needs explanation, put a
> short comment where that choice is made.
>
> If you want to give your LLM some direction, ask it to first reduce the
> commit message to something like:
>
> Background:
> einj_inject retains a pointer to the cxl_dport.
>
> Issue:
> The debugfs file can outlive the dport.
>
> Impact:
> After unbind, writing einj_inject can dereference the freed dport.
> The stale directory also prevents recreation on rebind.
>
> Resolution:
> Remove the per-dport debugfs directory when the dport host is
> released.
>
> Then turn that into a short, flowing commit message. Do not expand each
> item with everything learned while investigating the bug.
>
> Being able to summarize a change this way is important beyond making the
> commit message easier to review. It also gives reviewers confidence that
> the submitter understands the problem, its impact, and why the proposed
> change fixes it, rather than simply forwarding an AI-generated analysis
> and patch.
>
> On that point, please also say how this issue was found. Was it found by
> you, by an AI analysis tool, or by reproducing an actual failure?
>
> Also, how was this tested? Did you actually unbind the host, access
> einj_inject after the unbind, and reproduce the UAF? Did you then verify
> that the patched kernel removes the debugfs entry and that it is
> recreated after rebind? Please describe the actual test performed.
>
> That information gives me considerably more confidence in the patch than
> several paragraphs of forensic implementation detail.
>
> -- Alison
Sure, I will cut the commit body,  and explain how I test it.

Best Regards,
Guixin Liu

