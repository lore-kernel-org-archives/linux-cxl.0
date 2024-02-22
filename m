Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB4115530A
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620904; cv=none; b=LdWiu91sRdPd7jBJDSjgry43SwY3uGP1dEMb+jwa0qn84OaMqr3gEhlYT2cztgCUFlnblOJHC9mER1Eql0BdlvQEFF0QWoRnUnvuLSvemA2zj/x3wnWYO2WuzkXU3pQSKZ5o/JC/5ZLuj28QHPpDzYK8rzfBUaWlBscMpEPBOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620904; c=relaxed/simple;
	bh=E4NbgHvicTFXbgOqaQbImT9G4fAJAvJKk0PGcY8isMI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ryx+xDEYTICaVMtoKziQ1YaVpzN9ynSfFrlUtBkA5w6xAU0EDShu2eUR/6RCivp4VJgzJAN/6GI6zfYU99OBLsL7KwIHpSQVZi+TtrfIuiWcrlB0fhFKAMsTOUSbstQR+0a39o8t4PP3jI5OzTJLA8H2EPHEVMaEEZE/rFx7o34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPQnvPHi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPQnvPHi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dc1e7c0e29so20363145ad.1
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708620889; x=1709225689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csa0J0V6+LFxDu/YR9wQBUMQygQKV7FR3Ss/i1Z/wf0=;
        b=XPQnvPHiLQmZGqoncp1rtFEjFKA/ghmqu5srsLtJaYkKeHqZjXmvL2oYkO+xAG25yc
         IJuBf/e93tzFXRdqqkalPDHzzf4hXZTp0eUl3nFyU4wdrxhUbb0VlqSG3UqHjLANmDVZ
         8XSdusdkG6w9KLvWiDkaF/FsnORSVlcOkNUm/STbuSOU4LaofdSutlmB0k1/tnj04wAS
         eojYUbVyyBKjs41V1b6xOXnXwEsZdbpXmdEbBJiqI5MnF1KfEqM9xgGPnEW/opTGGKBy
         CoFq0KBkGXGlQotM0EkKqeocV9rVI/T2GlvObDRS7qaa90RsZzXXtPlwZAPLcNBumz9s
         /0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620889; x=1709225689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csa0J0V6+LFxDu/YR9wQBUMQygQKV7FR3Ss/i1Z/wf0=;
        b=urstK8VpUbGY1b3ngwWK4k8wGRXIzjMJIrWSx1GBk2Pplie6rT/CJcuA1Qt+pbb8Dk
         H3BhrTsNzMk49u1v1uox91o/bjRvIwwimie1Fld/A0dDXfwjXt/cPddaxzfpYcjN5vBl
         3Hu2gxP3u8D6D2tarh+f4ZQA613XLdHiWn0miuyhDYVKV2m2hti8aL6ZqPq2s/IDb1iz
         UnK0fQKtEiuszFVd0olISrGw4+D7PwWBSySKn4sO59kuhWLxShHK+Lv3ruuTFQwrPUV5
         PjjeW7yk9IuAPwYMXhu7pkFRF+nPjQ2fV1gNJx4HkphNThiTrlxgOvIc1XpmWpceTBxT
         lf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyNl4jcCKpUupSxYHAR6GjcSXrf/d18SxEOuld7yv7H34tNtosC4KJEUIpiTvtlA2iy45Jq1zzpJys61zJ9vwt8maN1Z+JrXsu
X-Gm-Message-State: AOJu0Yzc2+7VYy09UwjTpBtZGvlZD5mKHOB/qNLmYurVkq3qs5EE4I3S
	RdTw5rvThTEaTqkI11BajCl7sAsZmPfctcvSkLGC7W5MkdgBnj0y
X-Google-Smtp-Source: AGHT+IHbMfXTG1dtFPimRpl1wfxBamgRiDiQPfpcwamC/Z152FCaKxp4v/HWD0LQvC1NcRJkILrTkA==
X-Received: by 2002:a17:902:700c:b0:1dc:2f63:dfc6 with SMTP id y12-20020a170902700c00b001dc2f63dfc6mr5085045plk.53.1708620889083;
        Thu, 22 Feb 2024 08:54:49 -0800 (PST)
Received: from debian ([2601:641:300:14de:f32d:6b5:d03a:44f])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902761700b001db8f7501b1sm4676735pll.2.2024.02.22.08.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:54:48 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 22 Feb 2024 08:54:25 -0800
To: Wonjae Lee <wj28.lee@samsung.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	Jim Harris <jim.harris@samsung.com>, Fan Ni <fan.ni@samsung.com>,
	KyungSan Kim <ks0204.kim@samsung.com>,
	Hojin Nam <hj96.nam@samsung.com>
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <Zdd8QZk_fDUs1S6E@debian>
References: <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <CGME20240221182126epcas2p1b684f9239e4262f17ff484939658a382@epcms2p1>
 <20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff@epcms2p1>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222074525epcms2p1099bf72b0683889b36a5c5c06bdc2dff@epcms2p1>

On Thu, Feb 22, 2024 at 04:45:25PM +0900, Wonjae Lee wrote:
> On Wed, Feb 21, 2024 at 10:15:55AM -0800, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Per cxl spec r3.1, add dynamic capacity region representative based on
> > Table 8-165 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> >
> > Note: decode_len of a dc region is aligned to 256*MiB, divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> >
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  16 ++++++
> >  2 files changed, 126 insertions(+)
> >
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index ba1d9901df..88e3b733e3 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -22,6 +22,7 @@
> >
> 
> [snip]
> 
> > +#ifdef CXL_SPEC_AFTER_R30
> > +    /*FIXME: need to set valid values in the future*/
> > +    stq_le_p(&extra_out->num_extents_supported, 0);
> > +    stq_le_p(&extra_out->num_extents_available, 0);
> > +    stq_le_p(&extra_out->num_tags_supported, 0);
> > +    stq_le_p(&extra_out->num_tags_available, 0);
> 
> Hello,
> 
> It's a trivial comment and doesn't have any impact yet, but shouldn't it
> be stl_le_p()?
> 
> Thanks,
> Wonjae

Hi Wonjae,

Thanks for the review. You are right, will fix in the next version.

Fan
