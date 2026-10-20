Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.212.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454672;
	b=nK3hR7vG6CzkLVlx5HQkgXg9FkwtUs5/6Qh4ouCmnRHtZRIkeH+l/aHZVilRdXWImhqC
	 w/jXj+Io999V0zAbzj7QA9eAiTEvLoLVsvVrBKVGWTvC+U6F05sMay204e+Kb+AcVB4pe
	 iNeoBNwW7VRKTm/wbT3SQxuiGyK9qWd92cA5sfYWlQXwDCnqAECb34JoMdulOeBK5fgX9
	 aKFK/HsRZJfZiZhQIm16iz90LYPh/JQ9oITMcEx/LBPUHV7/MpzeUkFjFElrnH9WFKFCK
	 u/as/ujHY0ukRyyyffrJ6RPpX4/LJVPMSPRvC1QqtG4YFCrpigNb7dRdbZ5hNYGNy9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454672;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Company-Thread:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=kTGnnUmd1kd1TSENjN2WRES6CeDVby/TbywjhLroTj4=;
	b=O8yfVRyDRhToo5JN5LvZK96HHwYdAjLKit1IM/Yacu2IrO3igfijLKnT7CdWEMaFY7t1
	 VRzehRf+0Bp+Zj4VvyYG/AgLYd5C6Q56vkQWKOgeL39JwbcWq94Uu6wMqxtMEcQFg2BKD
	 0z3USwQE64YLx8KaetnilQiXtFtJyddIAWWfya7Pg54rg4h5lG4uGZRjoYqJeNX15Em/k
	 lgocf4xXddpwsiW8LnOl+jJgAaq64bhBeMniNijCyRtjOrLsi7j23DLPBB7RSnMIWHkTe
	 VRqgSxQvi8bQIVGluhiFXQjib9tmotajzhy7xHOj7QiABYa1q9RaY+3xxTwcZ0P/VnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=HxE1utPC;
	arc=none smtp.remote-ip=23.83.212.47
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAA606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 00:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59CAA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=HxE1utPC
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 519B44E0690;
	Tue, 20 Oct 2026 00:04:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.96.11.208])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 14F734E17E7;
	Tue, 20 Oct 2026 00:04:24 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Thread: 3db0625c6293fd19_1792454664172_1317013921
X-MC-Loop-Signature: 1792454664172:3589027378
X-MC-Ingress-Time: 1792454664172
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.11.208 (trex/8.0.2);
	Tue, 20 Oct 2026 00:04:24 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4j7t1z2Q7yz35;
	Mon, 19 Oct 2026 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1792454663;
	bh=kTGnnUmd1kd1TSENjN2WRES6CeDVby/TbywjhLroTj4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=HxE1utPCY6Vcoz3mFxPXJ7PvDcTcNvCqA3Pmv2VpachiQJixjT4yHW8Jnt6gTzSti
	 0uvogt8jMAk6au4jqHx66ynnOdT3xv/BOxmu5FprcOglcypeiMY5ZSLD6LIuRMD+uq
	 Or5YOuFO12NX5WTLkhp9r77sI/izro2kgSDyzDDoe/OC9jPxiG7S3r7pYNSyUtaTf3
	 mdkrJWuBImrymL3TlA/axCFO+9FLRwnR5Ayji/j4+F1V8njqLUAktwC1PwHwYiwVwX
	 EwaQkB81SiK7BHHewaQtU9/RKMpcAG76RUpxe9hc0oTWyh+I9TUmgZ+EKJb45pZi4K
	 GJbcE1EAPq/Vw==
Date: Mon, 19 Oct 2026 17:04:20 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: jic23@kernel.org, dave.jiang@intel.com, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 04/10] cxl: Add HDM-DB region creation
Message-ID: <20261020000420.lhm5wnqia334z2mr@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
 <ar3TU4IM_TtcGgwl@aschofie-mobl2.lan>
 <20261001085728.ko2pi62yweg3klnf@offworld>
 <atahRv-lm9yzq69R@aschofie-mobl2.lan>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <atahRv-lm9yzq69R@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Mon, 19 Oct 2026, Alison Schofield wrote:

>On Thu, Oct 01, 2026 at 01:57:28AM -0700, Davidlohr Bueso wrote:
>> On Wed, 30 Sep 2026, Alison Schofield wrote:
>>
>
>I'm OK w responses on this, with exception of what really is
>a new concern about qemu version compatibility -
>
>snip
>
>> > > @@ -198,6 +200,24 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>> > >			dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>> > >				cfmws->header.length, expected_len);
>> > >
>> > > +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
>> > > +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
>> > > +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
>> > > +		return -EINVAL;
>> > > +	}
>> > > +
>> > > +	if (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
>> > > +				     ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) {
>> > > +		dev_err(dev, "CFMWS has no coherency model\n");
>> > > +		return -EINVAL;
>> > > +	}
>> > > +
>> > > +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
>> > > +	    !(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)) {
>> > > +		dev_err(dev, "CFMWS BI requires device-coherent\n");
>> > > +		return -EINVAL;
>> > > +	}
>> > > +
>> >
>> >
>> > Can these checks break windows that are accepted and usable today?  A
>> > rejected window gets no root decoder, and auto-assembly then fails with
>> > "no CXL window for range".
>> >
>> > A window that sets neither coherency bit is accepted today and can hold
>> > auto regions, since assembly never looks at the restriction flags.
>>
>> I could remove the check for no ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM,
>> but would rather break bogus firmware.
>>
>> >
>> > A window that sets BI together with Host-only, or BI without Device Coherent,
>> > is accepted today as a non-BI window, because BI is ignored.
>> > Manual HDM-H region creation in it is lost as well.
>>
>> We cannot accept UB scenarios, I think these should be rejected regardless.
>>
>> >
>> > Even if no shipping firmware does this, is cxl_acpi_cfmws_verify() the right
>> > place for these checks? Til now it has only rejected windows that cannot be
>> > decoded (arithmetic, alignment, ways, length).  What a window may be used for
>> > is decided later, by cfmws_to_decoder_flags() and can_create_ram|pmem().
>> > Might it be enough to withhold CXL_DECODER_F_BI for an invalid combination,
>> > so that only HDM-DB is refused?
>>
>> Yes, I think this is the right place for these checks, aligned with its
>> name cxl_acpi_cfmws_verify(). These are minimum sanity checks, just as you
>> point out with those that cannot be decoded.
>>
>> I will leave these checks as is.
>
>
>Hi Davidlohr,
>
>This patch makes the currently released QEMU unusable for CXL.
>With released QEMU versions from v11.0 onward, the CXL windows are
>rejected with:
>	cxl_acpi ACPI0017:00: CFMWS cannot have both HDM-H and HDM-DB
>That comes from the first of the three new checks added above.
>
>Git history tells me this started w Jonathan's patch, in v11:
>e6742e71c24c "Update CXL Fixed Memory Window ACPI description to include Back
>Invalidate support"
>
>And goes away when your commit sitting on qemu/master releases:
>cb52f088f221
>"hw/cxl: Add configurable CXL Fixed Memory Window restriction flags"

Yeah this was an unfortunately situation, thank you for taking
the time to run into it and raising this (I'm normally the only person
running this stuff :)

>
>Was there already a thought on how to handle that compatibility issue?
>I can certainly test this series against QEMU master or Jonathan's
>working branch, but it seems problematic for this patch to make the
>currently released QEMU unusable for CXL.
>
>Could we instead avoid failing the entire window for the Host-only + BI
>combination?

I really think the kernel should do the right thing and forbid UB,
regardless of qemu (users that care enough can just upgrade).
One thing we could do is drop it temporarily and add the check a few
kernel versions later (which would give distros some time to catch
up with the new knobs and mitigate some of the exposure).

Jonathan?

Thanks,
Davidlohr
