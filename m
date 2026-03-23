Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799B854654
	for <linux-cxl@vger.kernel.org>; Mon, 23 Mar 2026 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244274; cv=none; b=R4ZGekWau1de7xNSKxQwx+rF1L68t6DgCvoEZBZVle7P933M/W1JFFOR5I/wMRnBJ53vcrbvz+mWvDUIvIW/YcvG9cgWSZ3dH+ztElwmUQ8ZZQ6LpN9wTZG6Nj65ExeLmLkf/AfEnRkGoaMkYG2VZzLFCKxG79s3XcFkvHcihrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244274; c=relaxed/simple;
	bh=wDaqZ2jF94kJR9bG7QnZEQCKVo6+1vG1RJvhGhdVIQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W444HKsSzb6AxxGIar9BMUpDnVtRnFzN8EcEThddTHc9lSxBvrjkCTMpHQGSi8nevP5/UVm58WQRL8EZX9U5QwM4YK0odvHB55fgXZQUF8nfL485Szn2H+tlQHoZFo9sZO03yEjzqQNeOsBahC8ZIilnq/LVniVil6rGZrCvsDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XIBtvL9H; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XIBtvL9H"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfc497a604so392547985a.3
        for <linux-cxl@vger.kernel.org>; Sun, 22 Mar 2026 22:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774244272; x=1774849072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eznnwyONrV2zfnlYhXqFCw+ScBb85TQDOYN9JM+ZwY=;
        b=XIBtvL9HNzFL0OlqmOkpWQ96jOsDt7VXJGWhyMc6hWIENDxkIVBAJWXUqM+z5InrX6
         JYDuOngNAQLeHISu1Gqd6sgQ5EtFjkzoEhbVZCHsTbiJIe+g3TAIrdM7TPSNdVRhzH5N
         9oRIbEu00/jZcR0iY1+Iyvhe6QRuFIPUL/ykl4m6LWefWyY1q6ZgexyGhN4AthOrp/zq
         hYMLyJ6L6xcTqw7ledYjMKpzrLDDCeW40NTnNsZyv9Ws6CIX11AsAw01PpzCyrG4+RlR
         IT8MUXyzvC38b9HgJxmtuhyjZAs46OaaifdjyhiEMLHPACv62zp/cnt48dRhFAbZtb+G
         d1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774244272; x=1774849072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eznnwyONrV2zfnlYhXqFCw+ScBb85TQDOYN9JM+ZwY=;
        b=fotHC/zqGAXRhthK9K6M9060bLjSdg7Y6KzWNJrVcEzHGFpfwP0bIQRmUCYnqpzPwb
         Z4hRmbbhpBkR1bU/VIGGsIEtEXoi4flkMEtGlPZDusRE1Eo2lKNRqxNDbl9Xt46Gt+2f
         RPAIdGDo5aszagiz25iggGEvMgN4mEsJqgAb1XavhopBNUgPE3Dw02Y5+WXlEZcx+hBc
         SoD+lgXRRTc2kPcaB+Ee4vTSGMAYJ0H/Ov65h7MEU/yuH3DPk4o/vyam6WTNJGrgZDrC
         Xu8ZlhUdhPm2eo+LGEuyaSFJI7C8t2S8GVVTMGsPyZYR4l6Au6S45xLhzWVurmsgByC8
         ptLA==
X-Gm-Message-State: AOJu0Yzdk4wxc+wvl7/3q2HI04OHFoBOi6Bk9ZqcI3EL8dyUhvS/V6pH
	0GRZFkkVYs5FWXVUpf2u6NO1ULwYBTpNCoCB8fE6qPjz6w13gWyjti8nvb0NI+fPn9o=
X-Gm-Gg: ATEYQzxTLyska3lsz6E8SBtApTuhKNKV2OKqbKEpSkA0wHVM2mbZPvHlcPQg3bNxMQD
	q0OY8V10mJLyeaaySHWRMRuFaCqLP5rs9ZTQOnDWZe0xBIydkQdoOngzV4YcXPZxlBd0gl6TueS
	6q5gE5KFsre+gyJnRh3zF/eDEuaj7+GDmxBAP7zcK3hMetC1KSUv3mVz0ngDzPmV4aDcJ5g7N4c
	ejgqDg5cmxm8Hq93zM8SfAxvi+QMQwGUDfUB8hMjA/h0A+SeRwz4FvB4/gL3eOHz/2UR8jT1jmO
	hIBpjvACfQ+r0aATuWSl0WOcai8BC2Rdy8pMMU0PpG4LDJn+4uxeV/TdRvNSreTbsNlnCwgxham
	HgILVLbZdqkgA5Nie6YZvstBVnzUZBx7IFnID28a5Y5ys2OFzdIE6eMUC4EWyMnLEY2ua71Rz9A
	u+/O4ij1VeHMDmYNnEeVvCMNVqZmDbP2HqzYGN+cTbEAM5BbjwCoWaw0qM3E5yiek/VBrfsUekN
	ZAUp4ZAzQ==
X-Received: by 2002:a05:620a:25cb:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8cfc80bb85bmr1589794785a.57.1774244272450;
        Sun, 22 Mar 2026 22:37:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc90b49d4sm696195785a.33.2026.03.22.22.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 22:37:51 -0700 (PDT)
Date: Mon, 23 Mar 2026 01:37:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v4 1/3] cxl/core/region: move pmem region driver logic
 into region_pmem.c
Message-ID: <acDRrRchRUSRBUbm@gourry-fedora-PF4VCD3F>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <20260322131638.3636725-2-gourry@gourry.net>
 <acCnaN9MIRByjUPd@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acCnaN9MIRByjUPd@aschofie-mobl2.lan>

On Sun, Mar 22, 2026 at 07:37:28PM -0700, Alison Schofield wrote:
> On Sun, Mar 22, 2026 at 09:16:36AM -0400, Gregory Price wrote:
> > core/region.c is overloaded with per-region control logic (pmem, dax,
> > sysram, etc). Move the pmem region driver logic from region.c into
> > region_pmem.c make it clear that this code only applies to pmem regions.
> > 
> > No functional changes.
> 
> This always adds region_pmem.o regardless of CONFIG_CXL_PMEM.
> Are you heading towards conditionally compiling, where region_pmem.o is
> omitted if !CONFIG_CXL_PMEM? 
> 
> Similar question for region_dax.o
> 

I hadn't considered going that far, but it doesn't seem unreasonable?

It just seemed natural to break out the code this way, but I don't know
if adding more Kconfig cruft is worth it just to save some .o's and a
smaller amount of code.

The recent pmem/nvdimm Kconfig change does kind of show that we might
have some bloat for some deployments which might not care about pmem -
for example.

~Gregory
