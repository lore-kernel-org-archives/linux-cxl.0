Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCA3769F0
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141033; cv=none; b=of4QHjopR15/DWnH8WZ5kqI5AMT3jpIM4gUzhbLcqMo0zqbiCW4/nuGy36aE1eymgP3485OyycmYwv9H6zGLGv2wGQ9pPFil5eCzkwqiwvFxhIGjEbJl8B5njNSzBP/BKYTn1hbK/C2JLIXcAhQ4yCDKn9hSVKvXGOvZdojFj9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141033; c=relaxed/simple;
	bh=6ogna+v2QXsvK+MFMfQumDvVUCLJoPBwCqRHUAunLOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rQ3npKqK9Z70ZEloNFT1WXFTF5WcuQH4ZrR3Jzkuwk6f3reAaYLPw43rAyAMI6SIEaN1yisZgyEWBeI5ReWNOCT7RoATGbPnudSXQnSRWKuz664Wi4rVcmNj+/jac1OI2H6RybUT5BgoB+f/p1MpGJnT0tz75eJCn6tKmvIDMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EX4+hVuA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX4+hVuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785141031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gEY32oBjPDEGLInOOJ3xLmZYuzAbeEx9u84r6JKPpA0=;
	b=EX4+hVuA11FUOzWrcwRnhs8L1EvrFg1Je1Kr6/j4oyxibtTh6f9mFj420+gCjVTWT/ew2Q
	DA7Tb+rqhW937dS5UVRv7ec9HduCeyZMU7YiWcZ6SBj+GniYXzwYJiIsz1ZZCkdix4BVdH
	5sXHkQ+vb0SfPPVNL+LB42c31xClwBA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-PHMl3tFhNFmwXX-gd_qviQ-1; Mon, 27 Jul 2026 04:30:28 -0400
X-MC-Unique: PHMl3tFhNFmwXX-gd_qviQ-1
X-Mimecast-MFC-AGG-ID: PHMl3tFhNFmwXX-gd_qviQ_1785141028
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f7700ffdeso927150f8f.2
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 01:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785141027; x=1785745827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gEY32oBjPDEGLInOOJ3xLmZYuzAbeEx9u84r6JKPpA0=;
        b=iQj/ORgF0G1YzuCA7IZlNJTZfhljncrTikb7VHPa8v4roTR64x/9pReXPcm+EMAess
         0Cxal0jQFmyY2qfDd/x072afTxw6rKuDtme5W2Nd/l1TGgB5XADGNbSui1cDwLAduvXQ
         TMeXKH+XctB5pDbY4yde2o8VlIIAaKjRnAlOo8bnj21qJIyXzA+VQ+90OuX4OVrBdh8D
         li3PzECpxsbLoBhw6rfbbAwMKE9izeWEGkwnMmldWEFFPPsrj3Y9kW5sIRv7gPHdo9Ug
         wSIu1z/Yu72qL819jb7/wnoEwaPwaTUO/0yrdfHOp3uIC7imgXfj87gvSq/Cogv6vEG1
         Svsg==
X-Forwarded-Encrypted: i=1; AHgh+Rqaq4OjuY1swHt79Qstjxp8YdcuXsyfrMTvbWY/5aWtV7AvRna76co0B5Xe/OBT5HAxd4j55EhYbL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTzP3CxkTQTDRrfMbvG01lAcxHZQAdpRbQGy+biHUWPdjw1iT
	M9TrUonEX8i4PkADqAlkPhhlfLzfgvgJ6PuEEDOOJXMi6mU4Q/pg+od8RDHLuRUS2YvE8zMJWS8
	woCCUo4FJ2OXN9A4x3yvjoHgOxTvlBoQ+E2hLbBXMGWVeDfKNVqYZwIy45JLeWQ==
X-Gm-Gg: AR+sD10TAK9EjoH3dyhbIBFOkRXQ9atLE3yXs9f3vL9DClgeyX1w/84bWqDM1spacit
	qhDXW6rlCJgHkIkNdWg1Yf4PkJXSPBhXi4lH7YCC2cjDkFMCO6KXLqPqJ3ayfSdAnVOX6EsDpCs
	xY78VwKs9z40Qy8OMh+UaZVjlEbfmppVN1d5DiF2lTGZbVlI/vFZ7Ft5/ir+rqhTd+Ozkm24j8a
	ihDeFptVocCCspcxmc8D7jn734pBYygHrjM6wJvK6OTTiEQSBK6yCBPqSUUMK3y4dig+MsQFmQD
	TJz/3NwgqQDlsXBA9ykVPbRCIM/ZogZgr1XVzC/hyn+Ho9xPEVeg44rq8ifSuB+iiJoo98wBXd5
	+pTeEI8xOQX6Ev2fo5rDbWA==
X-Received: by 2002:a05:6000:1867:b0:475:f100:3607 with SMTP id ffacd0b85a97d-47f9feb79fbmr9749595f8f.54.1785141027544;
        Mon, 27 Jul 2026 01:30:27 -0700 (PDT)
X-Received: by 2002:a05:6000:1867:b0:475:f100:3607 with SMTP id ffacd0b85a97d-47f9feb79fbmr9749082f8f.54.1785141022877;
        Mon, 27 Jul 2026 01:30:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm44005943f8f.10.2026.07.27.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 01:30:22 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:30:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Message-ID: <20260727042804-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
 <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZSm1RC2RW6lfYpi8simomDR0QCWB9UC6u549DYj58I8_1785141028
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 01:40:48PM +0900, Akihiko Odaki wrote:
> On 2026/07/27 6:09, Marc-André Lureau wrote:
> > On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
> > > > Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
> > > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > 
> > > Not commit log really?
> > 
> > SSIA, but I can make it longer if it helps.
> 
> I agree the subject is sufficient so:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> That said, we can quote docs/devel/style.rst if desired:
> 
> > * Variables declared with g_auto* MUST always be initialized,
> >   otherwise the cleanup function will use uninitialized stack memory

I like that. But the question is not just whether it's required by
the coding style. The question is if there's a bug and how is it
reacheable, which can guide things like backporting decisions.
Thanks!

> Regards,
> Akihiko Odaki
> 
> > 
> > > 
> > > > ---
> > > >   hw/cxl/cxl-host.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > > > index 7e744312f1d8..eba13c9e7cba 100644
> > > > --- a/hw/cxl/cxl-host.c
> > > > +++ b/hw/cxl/cxl-host.c
> > > > @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
> > > >       MemoryRegion *mr = NULL;
> > > >       uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
> > > >       MemoryRegion *direct_mr;
> > > > -    g_autofree char *direct_mr_name;
> > > > +    g_autofree char *direct_mr_name = NULL;
> > > >       unsigned int idx = state->hdm_decoder_idx;
> > > > 
> > > >       if (ct3d->hostvmem) {
> > > > 
> > > > --
> > > > 2.55.0
> > > 
> > > 

