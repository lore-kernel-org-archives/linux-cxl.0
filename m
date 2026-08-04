Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3747604C
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867180; cv=none; b=FvcmAohourbDG+L/bFyqSOeoNCScYNbhnDDdu0PQrEbJIGW8oE4OOmvMjb5CNH76J1wT+N2UACxMw9LXXyF7mYyJPhRfNIBjqgk6P8CdQ/qjuQHs5PoA8gsEHFNM4f3oYRJow4v5sC32taXHHWTJnXrriYYs2mgsq3pVibjjcVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867180; c=relaxed/simple;
	bh=NT9Qi2eMGwG0QI/OnKkKdPaeDSMLaxRU32STllPny8s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzk9EhuTOakXE97xAMvT8CM11LyXpHSCYMAfXxW+IR/sP4pkkRBex8Kzq+covyMAhUMnngrKxLgFZanKTtwJum6oDzOh83WlOLhnHwpGThRbXzENeAjrj2kcYXCGFvm+1GxADS5wp+ww4IyLe8iLJ9c8x+ZbJt2d8u3dkzkMAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2mBaNRA; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2mBaNRA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so119898a91.1
        for <linux-cxl@vger.kernel.org>; Tue, 04 Aug 2026 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785867177; x=1786471977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yX7DTtC7q+PlU+NI840IY/UHNK94JJqd3SZG9x5s1lY=;
        b=H2mBaNRAu+Xg3occTorB+qRg5rO+KzDZt/mAcjHQmy+fe5aO1L8GZYFxuo6ksFGSIR
         wL4Ux+HE0wbNkKF8q+/MFo/PrbPs+grc8v9tGjNqVrQAFr3Z74izoibNvGPs3gYfvLUH
         SXAQwjng+XmiYvsuy7jMAUfW99e6mzvwModOvAPemgjngQi1tx00bESRpyNXt1r49975
         IF38wLkGAZGM/q43OF4KeqafnyO8WWUZU2hNo5zULGiPm43XgZgZS0Fct3VL/NqX8tIc
         I/craB1RLyuTjZ21RrVp3vOxKqOJmedrgeixIjthzTnQ1JgXjPwhss1NS0T3zyV0hgnf
         +Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867177; x=1786471977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yX7DTtC7q+PlU+NI840IY/UHNK94JJqd3SZG9x5s1lY=;
        b=VXZg+Uy3gZAd8dA2hBMk6r8FmUkaXHXMM6jq/u00U6JdToOYcq3Zw8r+Ryji+wNrzd
         okB9AStb6TPPzelEsu7pF5eSboujdf/ofa7PRRqjfRtOD9L6fCfEn99LH/g+krhJACXq
         lBK653VSaSZM4h7aZ8m3y+I13R1AAb7VQMhY31cTOMCf7Q61jM2dabfeEWietGMA147a
         bBaRuwhZ7TkG2ngRP+eiIiYcwDOPNPc2yc2G2DFKlauD1MZiAw9WnFG/cI3hFWMXhWmg
         DFR9Y162OoCYMTPXQDVqn2EoynXDPwJub46Mm7CxeasLyiuphEsrRwpxo0AThfM52Qq1
         xgFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoHyvzMP+Mo04uxHxHD1bkBzwrl6YVwYoCYc0qadEr4M+VNNtJX8BfSBifWfy768dMwqKtUGQxb6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjMFsVmXZAa8gMm9BtPo1zu/rwqg3TPikCfb07b5fRbYiDwp4
	R+Yt/4FlHNJGMlbfc79BWmI0TJt1QbKQixwaW/0tIvTA7PiMDIC76GkV
X-Gm-Gg: AR+sD13Te4ww6urYqVnLn9URVumc0fLMlOCABfELZkucLHJqyc7NGMEARdQAW4K1YMq
	Nc3SGVzh3tH5gge7kMZsUc3KUeYna5XVQaMpztozIYTXnNOoyarcncsOS3HyzSMEBM7UgoOvlUZ
	THCirrrqys/lxOqJAtUC0vttvSkEm2aEdEeZ0jqo9QmY+NyKCDWKcc2PRquAm/q7aT9pXK1DZ6W
	sKV36icEMOEOAYJ2n900m75b7R7I5JONDMqHIzpB8MEWuufoDX9C6JuEDBK5DKlIZcOQdk7hNmS
	KhrGlyI3tYY3uyaTZHU9OR4+JsDj9F/bjzlafHtNBRE2Ba2NAURrz4KzqdUBNIbYUYoAcLzC3yk
	kUxxUaHin2PQ1JCcxZgFF7IJ51hCRx7W6BhjEKPkDSdMm+ToPSX8z73PERvKv0bZYTiEcmJh5Uh
	Eu7KIiiJKRcC6vDFLrAsh3seFYcDWgu4C2F/pXLfhsjzFBXFMSQ+bv37Zg
X-Received: by 2002:a17:90b:51c2:b0:38f:23d6:b4b4 with SMTP id 98e67ed59e1d1-3903c6809f6mr725038a91.22.1785867177031;
        Tue, 04 Aug 2026 11:12:57 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febfdae85sm1787046a91.3.2026.08.04.11.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:12:56 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 5 Aug 2026 03:13:25 +0900
To: Alison Schofield <alison.schofield@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jic23@kernel.org>, Fan Ni <nifan.cxl@gmail.com>,
	Li Ming <ming.li@zohomail.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v12 1/8] cxl/mbox: Flag support for Dynamic Capacity
 Devices (DCD)
Message-ID: <anIrxeDKMRKU4dlu@cxlqual>
References: <20260731084901.1512819-1-anisa.su@samsung.com>
 <20260731084901.1512819-2-anisa.su@samsung.com>
 <anIZiJ8E0EXs2kS0@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anIZiJ8E0EXs2kS0@aschofie-mobl2.lan>

On Tue, Aug 04, 2026 at 09:55:36AM -0700, Alison Schofield wrote:
> On Fri, Jul 31, 2026 at 01:48:06AM -0700, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Per the CXL 4.0 specification software must check the Command Effects
> > Log (CEL) for dynamic capacity command support.
> > 
> > Detect support for the DCD commands while reading the CEL, including:
> > 
> >         Get DC Config
> >         Get DC Extent List
> >         Add DC Response
> >         Release DC
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > 
> > ---
> > Changes:
> > 1. mbox.c: leave mds->dcd_supported false so the hardware enablement
> >    patches can be upstreamed ahead of the extent and DAX work; the
> >    event handling patch re-enables it.
> > ---
> >  drivers/cxl/core/mbox.c | 44 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h    | 20 +++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 7c6c5b7450a5..4790524c32a7 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -165,6 +165,38 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
> >  	}
> >  }
> >  
> > +static bool cxl_is_dcd_command(u16 opcode)
> > +{
> > +#define CXL_MBOX_OP_DCD_CMDS 0x48
> > +
> > +	return (opcode >> 8) == CXL_MBOX_OP_DCD_CMDS;
> > +}
> > +
> > +static void cxl_set_dcd_cmd_enabled(u16 opcode, unsigned long *cmd_mask)
> > +{
> > +	switch (opcode) {
> > +	case CXL_MBOX_OP_GET_DC_CONFIG:
> > +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, cmd_mask);
> > +		break;
> > +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> > +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, cmd_mask);
> > +		break;
> > +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> > +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, cmd_mask);
> > +		break;
> > +	case CXL_MBOX_OP_RELEASE_DC:
> > +		set_bit(CXL_DCD_ENABLED_RELEASE, cmd_mask);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +static bool cxl_verify_dcd_cmds(unsigned long *cmds_seen)
> > +{
> > +	return bitmap_full(cmds_seen, CXL_DCD_ENABLED_MAX);
> > +}
> > +
> >  static bool cxl_is_poison_command(u16 opcode)
> >  {
> >  #define CXL_MBOX_OP_POISON_CMDS 0x43
> > @@ -757,6 +789,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> >  	struct cxl_cel_entry *cel_entry;
> >  	const int cel_entries = size / sizeof(*cel_entry);
> > +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX) = {};
> >  	struct device *dev = mds->cxlds.dev;
> >  	int i, ro_cmds = 0, wr_cmds = 0;
> >  
> > @@ -785,11 +818,22 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  			enabled++;
> >  		}
> >  
> > +		if (cxl_is_dcd_command(opcode)) {
> > +			cxl_set_dcd_cmd_enabled(opcode, dcd_cmds);
> > +			enabled++;
> > +		}
> > +
> >  		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
> >  			enabled ? "enabled" : "unsupported by driver");
> >  	}
> >  
> >  	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
> > +	/*
> > +	 * Disabled until event handling implemented.
> > +	 */
> > +	if (cxl_verify_dcd_cmds(dcd_cmds))
> > +		dev_dbg(dev, "Device supports DCD; capability disabled\n");
> > +	mds->dcd_supported = false;
> >  }
> 
> Hi Anisa,
> 
> I read and agree with the other reviewers that this does not need to
> mirror the poison and security command handling.
> 
> The one-use cxl_verify_dcd_cmds() helper still seems excessive. The
> bitmap can be checked directly here:
> 
>     if (bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX))
>             dev_dbg(dev, "Device supports DCD; capability disabled\n");
> 
> And then once DCD is ready to be enabled, the assignment can become:
> 
>     mds->dcd_supported =
>             bitmap_full(dcd_cmds, CXL_DCD_ENABLED_MAX);
> 
> -- Alison

Applied :) Thanks Alison!

- Anisa
