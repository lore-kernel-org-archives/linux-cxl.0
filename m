Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B62475E3
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429291; cv=none; b=jDCpstnW2TX3Ofq3ratX5b03a9ilCDdPFhrptS8wXOMuxi/PBaoJyfUJ1b3rIJfPX+ua0nnOtuwHKmr9r1GpJhzTzfTBHLlOuLhNcoZLRbcZqxj+FzY0MmDn4tPgAmOkeUSNlMLC5pReKybo4I/suy4x1Kr9R9TzZMURVrTe0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429291; c=relaxed/simple;
	bh=V55MeqyYEByXAvvQ+obB7m2FZlZH/VQKd9plf9c8UEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T5YDlNUlXXtAFAmJ4AjaRYxK6gLVJMYFC2RlHwCKkBx38DBhCvyk56zZ1SFAIk5oWtJQT541EjfZSM0faYFMa+wk6Nbz+1QNEFEoFS/u4Ucp+XYBx9XxaAbVlosPhaLJS3i6IPHyJZO2iHHkti4G2nQZ4HHWaNznbkIEQrn5htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D0NVjwlQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D0NVjwlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757429288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7K2qM1PAiI1ubms+Dwy7V8EYRo11d4cHmDiCJE3V+c=;
	b=D0NVjwlQFMLlnIGwDirZiNVbU6yupPMJEd8NytovZqgPnNsqrezUsceeB32lwbea2bdnJ8
	U4YKQV3KUKZSPqqKunG+Tsb6LHqHxvBLLVH9T1Xw2MEiebuaJ25kU+y117H1fUrbpGB0QM
	zjj8LbRK2d6dr4QorOLfp/RIpdBSMwk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-JVqZ21gJNbeNMAYNW1133w-1; Tue,
 09 Sep 2025 10:48:04 -0400
X-MC-Unique: JVqZ21gJNbeNMAYNW1133w-1
X-Mimecast-MFC-AGG-ID: JVqZ21gJNbeNMAYNW1133w_1757429282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E48D41800656;
	Tue,  9 Sep 2025 14:47:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 567831956045;
	Tue,  9 Sep 2025 14:47:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 23D9C21E6A27; Tue, 09 Sep 2025 16:47:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  ira.weiny@intel.com,  alucerop@amd.com,
  a.manzanares@samsung.com,  linux-cxl@vger.kernel.org,
  qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
In-Reply-To: <20250811125552-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Mon, 11 Aug 2025 12:57:01 -0400")
References: <20250811033405.332295-1-dave@stgolabs.net>
	<20250811033405.332295-2-dave@stgolabs.net>
	<20250811165741.00003aa2@huawei.com>
	<20250811125552-mutt-send-email-mst@kernel.org>
Date: Tue, 09 Sep 2025 16:47:48 +0200
Message-ID: <87qzwfvg17.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Aug 11, 2025 at 04:57:41PM +0100, Jonathan Cameron wrote:
>> On Sun, 10 Aug 2025 20:34:02 -0700
>> Davidlohr Bueso <dave@stgolabs.net> wrote:
>> 
>> > As with the link speed and width training, have ad-hoc property for
>> > setting the flit mode and allow CXL components to make use of it.

I understand this is property "256b-flit".

> I note we didn't make it a stable API for width, want to
> prefix this one with "x-", too?

The only use of "256b-flit" is in docs/system/devices/cxl.rst [PATCH
4/4]:

    diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
    index bf7908429af8..4815de0f2dc4 100644
    --- a/docs/system/devices/cxl.rst
    +++ b/docs/system/devices/cxl.rst
    @@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
       -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
       -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k

    +An example of 4 type3 devices with volatile memory below a switch. Two of the devices
    +use HDM-DB for coherence::
    +
    +  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
    +  ...
    +  -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
    +  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
    +  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
    +  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
    +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
    +  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
    +  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
--> +  -device cxl-upstream,bus=root_port0,id=us0,256b-flit=on \
    +  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
--> +  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,256b-flit=on,hdm-db=on \
    +  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
--> +  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,256b-flit=on,hdm-db=on \
    +  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
    +  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
    +  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
    +  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
    +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
    +

The purpose of 256b-flit=on is not explained there.  The only hint I can
find is in the commit message: "Devices require enabling Flit mode."
Which devices require what and when is less than clear.  Maybe hdm-db=on
requires 256b-flit=on?

Why does device cxl-upstream use 256b-flit=on without hdm-db=on?

I can't see where property "hdm-db" is defined.  Davidlohr, can you show
me?

I doubt users can figure out how to use this unless they're intimately
familiar with... what exactly?

>> > For the CXL root port and dsp cases, always report flit mode but
>> > the actual value after 'training' will depend on the downstream
>> > device configuration.
>> > 
>> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> 
>> Definitely include PCI maintainers on this.
>> +CC Michael, and Marcel.
>> 
>> Also Markus for command line bits.
>> 
>> Looks good to me.
>> 
>> Jonathan

[...]

