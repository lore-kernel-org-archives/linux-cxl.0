Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A799372661
	for <linux-cxl@vger.kernel.org>; Wed,  1 Apr 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775043593; cv=none; b=dUtuRGwaaI86UdHUQTAtRR71Cogvu0+H5kGN6k6Mz2X51svHU3VBrAsZrmtlmYAUMoSZJU62tJpG6ZpDDHyUy2UgFGK9DROkpVVBdIPE0I279aOYk/ZkwymZa0qPmBUnDdHK1aatzy5qKbf/IkgAvfpls6T/8hLLERAKMgxxxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775043593; c=relaxed/simple;
	bh=brLi2CxkT8OsknOe2gRnXgDDN6nDEXe2PCEZt8AxjjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aWIrQ1ynuV0tCv/WwDkHXyQizyEQhmuc5FhBhe6oczFQMAB7GAJsq3G3aB1lbL0yfLH96EDBC9lLA3EuEKiVeWo1YLWPSyrTMJmPEEcoVUPfu0P0AvOFS4JmcAdHAtfl1oZBjeq4yjDY2OM9ddgktH5iE5DJGsUS5sJCLDA9O/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKDXy8gS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKDXy8gS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775043591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqezalPl4i3JBcgLVBe3bFLBNdF5OgFM/6xHTa3bquo=;
	b=BKDXy8gSfPExMkyrSGqd6BX15T0FlhTTZ2dkILZFDJOIwzZxglHe8R/RRCWAyoBBbfKaMk
	Jb58k1iF1iQm+HvbBHVfX39ZdOQD7j1cIWgH++0kg4fIGVL+IM0E2xL2yUPMIVNdtxBdpE
	z0sXpEuuVAaaOObhf2cHJgOmOLhmJbE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-qe4Ff5YzMWiw4qyQPLAQqg-1; Wed,
 01 Apr 2026 07:39:47 -0400
X-MC-Unique: qe4Ff5YzMWiw4qyQPLAQqg-1
X-Mimecast-MFC-AGG-ID: qe4Ff5YzMWiw4qyQPLAQqg_1775043586
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B930195607D;
	Wed,  1 Apr 2026 11:39:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17205180058B;
	Wed,  1 Apr 2026 11:39:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id BAB5321E6A28; Wed, 01 Apr 2026 13:39:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
  <berrange@redhat.com>,  <eblake@redhat.com>,
  <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
  <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
  <me@linux.beauty>,  <ira.weiny@intel.com>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
In-Reply-To: <20260331155044.0000603d.alireza.sanaee@huawei.com> (Alireza
	Sanaee's message of "Tue, 31 Mar 2026 15:50:44 +0100")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-10-alireza.sanaee@huawei.com>
	<87mrzuei5f.fsf@pond.sub.org>
	<20260327151811.00005564.alireza.sanaee@huawei.com>
	<87zf3s1ohc.fsf@pond.sub.org>
	<20260331155044.0000603d.alireza.sanaee@huawei.com>
Date: Wed, 01 Apr 2026 13:39:42 +0200
Message-ID: <87tstu29kx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: fvLztn0JellFa5fpgwvyRvb7NtR7AZZBQYAbburlAR4_1775043586
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> On Sat, 28 Mar 2026 07:01:51 +0100
> Markus Armbruster <armbru@redhat.com> wrote:
>
> +CC Ira
>
> Hi Markus,
>
> Please look inline. I believe Ira might be able to help and we can see what he thinks.
>
>> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
>> 
>> > On Thu, 26 Mar 2026 16:15:40 +0100
>> > Markus Armbruster <armbru@redhat.com> wrote:
>> >
>> > Hi Markus,
>> >
>> > This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
>> > The process of removal is highly asynchronous, that's why I needed to add a new command to check it.
>> >
>> > I would be happy to drop this patch, as this is extra.  
>> 
>> So your motivation for adding the command is "just" testing.  Correct?
>
> I wrote tests to make sure extents were released, and I used this QMP command to check.

As long as this is the only known use case, we want

    # @unstable: This command is meant for debugging.

in the QAPI schema.

> Now there is background about extents where DCD was developed in Linux by @Ira, CCed [1].
>
> In the DCD extent tracking section of the CXL spec, I see some commands 
> related to getting the extent list, maybe Ira can comment here. To be fair, knowing if an extent
> was released or not is a useful information in general from orchestrator perspective.
>
> [1] https://patchew.org/linux/20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com/

If we believe there are other uses, but we're unsure the command
actually serves them:

    # @unstable: This command is experimental.

>> Can you think of other uses?
>> 
>> In particular, would a management application need this query to monitor
>> removal?
>
> I think management will get a signal on the removal given the schema in Ira's Linux kernel 
> patchset. I do not think this is implemented in QEMU at least (I might be missing something).

I'm getting a feeling of "this is underbaked" :)  But that's for the CXL
maintainers to judge.

>> The description of feature @unstable may need to be adjusted for the
>> answers we work out here.
>
> Absolutely.
>
>> 
>> >
>> > Thanks,
>> > Ali  
>> 
>> 

