Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BA2940D
	for <linux-cxl@vger.kernel.org>; Mon,  8 Sep 2025 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346278; cv=none; b=YEygimvHAqGkw4x5rB2RlA+OKzU4/OBPjGk77A87GzoLD/QFcJV7vrMf0usKbtBpoQHxexsVeHb7flb0E8IDe6GRND+FhXOMJbbltJ6/Efp/RC3xpXlDJ/+0wrtS7WyYyarEtLyBpFqRXHCJLuYHlKOfAH6+ZO8bwsMVn4PdZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346278; c=relaxed/simple;
	bh=w4HOuvFEcsPcAyaMXTXyP+nAjCgqIcSk/F3/S3Jwk4w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P//pViOTuC2e0WzC6A+9RfWfint4nUFqXt3YZpOkLYqmaKg4NJD+uI/+THuUKQLEezA8A5T1I+MkUj5Com1ZzqFETBmhpGASjBzG2rAYKz6vnag4ko/4NPQb9rOZQT5v0uIc8oeh0LvM5pr72ARJ9d1b+M6C/wwXiarNvXfq8UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=HqPk5eBL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HqPk5eBL"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so2137773f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 08 Sep 2025 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757346275; x=1757951075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fr8jiUrtkSu1+Ckh4vjVzE9iHDunNFqQkDe296VcZx0=;
        b=HqPk5eBLU//xuFCOwUzFVtDd8RATVaIpp4xNt+6CzIa51rvteELk83VDO0AyUsSNqf
         OKVKNCr+S6eQyP2Xt1cELhbOSi+mkzuqc1diEy8Y9dxLy13jmBbYxbN0ukmuACE7z9j3
         f3t6fys9dnaIDNFfvnEqkBf9Ta5arzwlMxvNuLHX1WNx2kB2SuSNPHp2/QmBF2qeosiU
         4fovAVQvaWK2ZXHSiUNNEq/RxRLZ4m0sSq0OThxHqRPuCvPL8GJq2T7l4JyNLIhwRszK
         V41PorJgZ4vIbl+pnar8IIFT9TxxBNNSJlsVtd2bdB88Q+4acf+s7zax7KdrfP6ZVOIk
         tYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346275; x=1757951075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr8jiUrtkSu1+Ckh4vjVzE9iHDunNFqQkDe296VcZx0=;
        b=NaBiw87B+z4z9htxcGEPmXhT7iJpBu52Fbo4GXqZ8YESQQYXnE6REXve/BQWCZg5b+
         DrpdKOuzukQ3TVZ8nzr/OMkAZyIbZZ76GBxk5Ju9xZS/sWZKLpNsu+TqwhFPgolx6CQQ
         rfpyDZlQdooqi+43rKPi5q+ydXn42RnaNY4DRXdXTWXN7j9h+wjIZBApk+saio9BsciL
         PK9bWRYBgrPhS02PIePzhJ8j1nwchGiYKJkmgPNjqPmUVvN2FldLyvHK5t17+Jms2dAV
         8ZKF6+EpqIm4/Do+Smcuasc2UpQhpqrYEwJcwdghV14Opi8mzmrEJt1ThTMH33AuGsQH
         XDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeXnGH2GYeZ3fDBwYG8/f2sPGJBRK4EtpX2kYc+JceQC4GiTFzIOF5QiEzDOal89+0hHxPQUwACUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbkvf5d2nqSVLwyyjyAPgYtaH/6S8leeaNxnMpAclk8A48XVjq
	oi/5f/mOgXezRROw7BSzUxAF+1M0OIUYsiqcsriRCm6vjiR+8BPTIEC/5iByYEex
X-Gm-Gg: ASbGncvXcBbhXbFKqNsCd0tK21l2Sscpx+j/hlx4unQbt7Fj3z/cDbspi+hILV3NHkN
	ofIQAHDyhVJdyWBct/X4yo5UJV1WJfiDZQPug8Q1S9PdOl7mfo4n/sE8J5/+vVAoR0DbRR8R2ry
	JesGwyLeJATG/ged1bMNPnd5xXxBSs8e1IVeU54yzNByWrCEBxOleimVgbrSW61oypt6PiLqYJn
	lGX+rOwBWMYaVh/jqszOF9ag5hKEsTTXP1VjSR+60530eS+banjm30rePkTUfwa8YAw+2EFqJac
	SA5O+suncUpnAMqcVQKG/+Fm0xBfu5FM7BMK0cOEM2GUBX1LlTXIQ5T55wdGvJB6KSjaeL664QU
	zP4QPXkfFztyaNdMo/ZeQFrkgBr8iQwAtnIvFj+0wJhsEQVCSB+a8wZBHwK3w7ZnwuaLeZYdEvv
	fOzKzEnDcIdKT3kv0=
X-Google-Smtp-Source: AGHT+IFF1SFUp6DT7tHdMGMOzTYsYWzRQWAjMSLyRE+42I8n5SbK7mimQBOMIoccqZNkP/EqIC/uaQ==
X-Received: by 2002:a05:6000:25c1:b0:3ca:4e3:6ea6 with SMTP id ffacd0b85a97d-3e645c9d1f8mr6533012f8f.46.1757346275054;
        Mon, 08 Sep 2025 08:44:35 -0700 (PDT)
Received: from thinkpc (shef-16-b2-v4wan-169484-cust5160.vm3.cable.virginm.net. [92.236.212.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e06dbde2d2sm18515967f8f.12.2025.09.08.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:44:34 -0700 (PDT)
From: Joshua Lant <joshualant@googlemail.com>
X-Google-Original-From: Joshua Lant <joshualant@gmail.com>
Date: Mon, 8 Sep 2025 16:44:33 +0100
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Joshua Lant <joshualant@googlemail.com>, linux-cxl@vger.kernel.org
Subject: Re: [QEMU- PATCH 1/1] cxl_type3: fix segfault in
 cxl_destroy_dc_regions
Message-ID: <aL754ZJlIUCOCotE@thinkpc>
References: <20250904090346.884649-1-joshualant@gmail.com>
 <20250904090346.884649-2-joshualant@gmail.com>
 <20250905155456.00005f7f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905155456.00005f7f@huawei.com>

> On Thu,  4 Sep 2025 10:02:22 +0100
> Joshua Lant <joshualant@googlemail.com> wrote:
> 
> > CXL_TYPE3_CLASS() should be CXL_TYPE3_GET_CLASS() given object (CXLType3Dev)
> > input. Leads to segfault in object_class_dynamic_cast.
> > 
> > Fixes: ef730035567
> > 
> > signed-off-by: Joshua Lant <joshualant@gmail.com>
> 
> Good find.
> 
> The Fixes tag needs fixing though.
> Should be all part of the tags block and needs to include the patch name.
> I'm not finding the SHA though.
> 
> I think that tag is probably Svetley's MHD callback patch which isn't upstream
> so I'll squash this in my local tree and it will be fixed in the next tree
> I put up on gitlab.com/jic23/
> 
> Thanks,
> 
> Jonathan

Yeah sorry, it is that MHD patch. I managed to write a rogue '7' at the end of
the hash somehow. Have reposted with updated tags block...

Cheers,

Josh
