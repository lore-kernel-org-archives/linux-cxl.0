Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE18329F2D
	for <linux-cxl@vger.kernel.org>; Wed, 10 Sep 2025 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.252
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529276; cv=pass; b=Vh8k+gA+nE07abcd44NwhsqpjX92Z4DJgU4UG1Wi4ZdPuqTZOGqSzqJVN8Aotm0y52jws+UjP7nSFZ4BNVscdPVei3DWysvZfT2jowiC8Bnbht2decAO4RrgXyqx8Ec53PrWHaBm053MfwmTnMsJmqK5AE0vQkvkw7RyY4BBUOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529276; c=relaxed/simple;
	bh=sohFzsvJBCKvR4VJtlELc3rotsD5MEOUbwUyt11bGMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny7xJIHe2LOr3uLSRwymLOmabZX4xCqs+SZOHU8W5If2j0J88+CcjHw3WVlSD083HdzJstf+oIpC5roOKGWH2h25MlBYFOdjx3XQ5+CVNB7o14n/YXEXi+SyThlwvLNRSalISU8k3eXHF7fiBGj1cjtBYGkc/rfi/RrU0uz3A1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=FnDGjMzK; arc=pass smtp.client-ip=23.83.218.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="FnDGjMzK"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E9B7A1671C7;
	Wed, 10 Sep 2025 18:34:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (trex-blue-6.trex.outbound.svc.cluster.local [100.106.206.222])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 070CD16704B;
	Wed, 10 Sep 2025 18:34:27 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757529267; a=rsa-sha256;
	cv=none;
	b=gpscblA86N2OohdKDqzHJunXyh3fu5Vqxase3fPr5Xi6WA9pmOu4T/4icXiez/M5DTc00v
	btcom2iwHOgMffty2rLmVqx7x0xpCUQeYdpU1uueWjF8H2wRPOBo1d7Zy8yHMvx9K38meS
	aQkhotzRfGll1Pem6OSMQ33TvvgDTWJbPZ8i62ndv5PsjbuSWNqp9FEM0uOixvbAKhuYA3
	6WDhGjpGlJprcNfZl9LZC4IznSOEqsWsAtTx0NF+P962/+7F4W0wouBrVkmvDwkzMnV6Km
	33yCU6xil2EjgEacYXz4JmFKNSt9/P3Eub6FJBQeO7L0ga3CW7bFkoo+zh2EzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757529267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=QtoKdIZCIxYRJPwPRa5RLmpgpbyew4buGzz8v6fy0hM=;
	b=b6MKDUHllTPEsThcZJwB7oO2OcbeH/8+LGf9pzb82I3B2lVgTmwZxs7o/oJxxNU4idJDAs
	zFrpqklpmpnulGlz6DbOQ8JnXj9WHSKeWWEKMZfIs/hepf6koHjO9VcEkfweTl3kI4OcNI
	LroEGw+LjUEafHQv9i4ZKFGlw3qVTZmcnEsDNmv8RYpBu99OWpATavj3WxtSjJrbGNK8pY
	n8dND7Rqd2PzBzDk78CyCKXqvp/Uap87o40bek1IRZITuKMUDcqSVqJkk8Ce/quL7w5txN
	E3bfIC6yaXuSYhmPl7Nay8n98vrD0aci+gbeEXBLpeh2Z/Vj7BMPxSKleE8uWw==
ARC-Authentication-Results: i=1;
	rspamd-7b5fd646f8-6z9df;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Spot: 0295cc4b1f59f496_1757529267314_2184550223
X-MC-Loop-Signature: 1757529267314:143896420
X-MC-Ingress-Time: 1757529267314
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.206.222 (trex/7.1.3);
	Wed, 10 Sep 2025 18:34:27 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4cMTqk2nwQzF2;
	Wed, 10 Sep 2025 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1757529266;
	bh=QtoKdIZCIxYRJPwPRa5RLmpgpbyew4buGzz8v6fy0hM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=FnDGjMzKiO+qdPJUHpThmeHpNlke/JLbnir0ukfwhjhnfHh79mfeUJmC0QbP1BWZK
	 F+yrXKQnDzaclr/95wbrzrc74513wUH+DiBpHY8+MpOdhl87mdpl5TLJRN5nz+MHtj
	 iGUNQgYu0kcOwQGb6NwwyPUxiY9uBZu3en/AOBQmj4q/bi8h+bcGU5ugHEx7b7C3Oh
	 7uDSny7iDHfc/LE835tR15bdqghDnulIuqhl0bb2uKIzUSOj0zoqQ92DhgzztIsdo+
	 c4B8ftiw1EH2KigaEJc/s49fXxRHIWYqfT7JmmHS2NGcU5xJJghZCs94jbV7QXyRJ2
	 ZIuSI2i5/vImw==
Date: Wed, 10 Sep 2025 11:34:23 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, ira.weiny@intel.com,
	alucerop@amd.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
Message-ID: <20250910183423.h6lky2kx5bynv7nc@offworld>
References: <20250811033405.332295-1-dave@stgolabs.net>
 <20250811033405.332295-2-dave@stgolabs.net>
 <20250811165741.00003aa2@huawei.com>
 <20250811125552-mutt-send-email-mst@kernel.org>
 <87qzwfvg17.fsf@pond.sub.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87qzwfvg17.fsf@pond.sub.org>
User-Agent: NeoMutt/20220429

On Tue, 09 Sep 2025, Markus Armbruster wrote:

>"Michael S. Tsirkin" <mst@redhat.com> writes:
>
>> On Mon, Aug 11, 2025 at 04:57:41PM +0100, Jonathan Cameron wrote:
>>> On Sun, 10 Aug 2025 20:34:02 -0700
>>> Davidlohr Bueso <dave@stgolabs.net> wrote:
>>>
>>> > As with the link speed and width training, have ad-hoc property for
>>> > setting the flit mode and allow CXL components to make use of it.
>
>I understand this is property "256b-flit".
>
>> I note we didn't make it a stable API for width, want to
>> prefix this one with "x-", too?
>
>The only use of "256b-flit" is in docs/system/devices/cxl.rst [PATCH
>4/4]:
>
>    diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
>    index bf7908429af8..4815de0f2dc4 100644
>    --- a/docs/system/devices/cxl.rst
>    +++ b/docs/system/devices/cxl.rst
>    @@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>       -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
>       -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>
>    +An example of 4 type3 devices with volatile memory below a switch. Two of the devices
>    +use HDM-DB for coherence::
>    +
>    +  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
>    +  ...
>    +  -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
>    +  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
>    +  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
>    +  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
>    +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    +  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
>    +  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
>--> +  -device cxl-upstream,bus=root_port0,id=us0,256b-flit=on \
>    +  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
>--> +  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,256b-flit=on,hdm-db=on \
>    +  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
>--> +  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,256b-flit=on,hdm-db=on \
>    +  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
>    +  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
>    +  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
>    +  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
>    +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>    +
>
>The purpose of 256b-flit=on is not explained there.  The only hint I can
>find is in the commit message: "Devices require enabling Flit mode."
>Which devices require what and when is less than clear.  Maybe hdm-db=on
>requires 256b-flit=on?

Yes, hdm-db=on requires 256b-flit=on.

+    if (!ct3d->flitmode && ct3d->hdmdb) {
+        error_setg(errp, "hdm-db requires operating in 256b flit");
+        return false;
+    }

The reason why it's not documented in 'cxl.rst' is because it's out of scope really,
and anyone who wants to go out of their way and use a CXL feature that requires 256B
flit will certainly know about it (or find out with the error above).

I'll go ahead and add some text in the example description, but the example itself
is pretty clear imo. I will also add some relevant text in the changelog of patch 1/4.

>
>Why does device cxl-upstream use 256b-flit=on without hdm-db=on?
>
>I can't see where property "hdm-db" is defined.  Davidlohr, can you show
>me?

Yes, that was a slip up while rebasing, I caught that missing while preparing v3.

Thanks for the feedback.
