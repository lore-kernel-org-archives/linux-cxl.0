Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315A41162B
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542882; cv=none; b=Faft1JTWarnm6vj+CgYXhZYtIteauPVFzLpeP7ReQ0BwoepLEkmN5QkwnMym0/uLPy7GFJ3M9S/qS+7yXZtzUQY9nJ86qfoLlMxBCwrdf5+qU7r8EBsV7HyhK1a4qlqcpPZ+p+Wrhbnx5gMqjio5RYGwu/orVgfFsWxEVx39l+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542882; c=relaxed/simple;
	bh=Ut79i05r6KmGU8yExp7cn4mMCYr3fnEE0l/7p0zhKrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUHXZOduF6j5Vhe7G1fFdm0jqeuTkXhLFc9bprAdDcQKKJMPK+CNUy/keDxzdaZJfzSZp3v/DASTnHYyjLXUnkJIIRb96uok0/mqFTjY802jixbO4QTCHcmp2tbeXsGBn3KqfS3Bea/PNzEq7yk/6tviyqSj9zNrJzICoKtDdO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H07Xehwb; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H07Xehwb"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50b2b289925so11382331cf.2
        for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774542878; x=1775147678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6ciZ7B7psiQWnK9EJFuh8TuUxnEOvrrtlB2iVfSnAg=;
        b=H07XehwbIj1YQpnfpE9eQLtj2dp564cEh8omGfM+t410ervk5SDBIuzLw/l1m/F0VL
         t/V2IklinGRbuveHKHqcBjhdwJbKIwnybwsugZqHBNWKp2qNVfr8tAeYwdJ8PzD+yXXc
         /uWl3I5i6VAFZy/R44R81VwJ3ed+RB2eLu8uagjc3IaNCuMhNaMZ1i2FLLHQEuG4eFxY
         M1BTvsEJyo1Lv/nL8lPYNxUcu249/IYJwmZRtYX+ALVttbA0PTmQf+Zw8dHXx3K/Ls4g
         Qa2erjDrTPaClEAeP3bZ9AfD7fYUzmevWKxAjqihhfdLL0G1/s+gL5m2nfSyz3DsH7a0
         TPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542878; x=1775147678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6ciZ7B7psiQWnK9EJFuh8TuUxnEOvrrtlB2iVfSnAg=;
        b=BHLAjteaebVPujYM+2hLbcCzd1I19QNgpgcjybf7TcpzUBD+YgGFdinDVwzToNc+1t
         d8YF3SAn0lb1TJ/ztjV7TmrpiSpXvBO0da1L2HJOC+HmXT4XCSELIPLNqmaN3UtNNBbK
         oD9nO3FhwDm4q3iMPotxQTZ0el6W58Ngto1zSER0RC6Op+SIpd09DchvumvSL/mV5aR6
         hmvI2gSae8CsmcTf5Kk+IGew/81loXJWxX05+fRi4ax3sbaSs7Kf4zIG0xnSfMkhUA5X
         FejsFL3gnfWWFsInV1OccHTrYszFnM5AOTdoz3A+s9cTDQsFClsFHCUMkeWM7UDr/ief
         ghiA==
X-Gm-Message-State: AOJu0Ywa9w7lFlCk21uSFGELTAbigZuqEoD05cd2WRF47xvzE+KajkRk
	+TvlE1KSLDGTEjceDVUqNaxZ6RmlqC6y4gNve4b2E3O5fBSWM72tRcynV8rOZppHga8=
X-Gm-Gg: ATEYQzy6abxv+UqeefWNddI0cJMhJ0X9VUaeEH82aAVnNZ7uIlc3ItKIaolZvPhYDrK
	M5POYqQupLES2jgnYWpLMcij2TFv4T/3nPZrY1SFWjizU3DhbcwZ0lURQ0MK67KnN2Tfs7UCDFb
	u8iWfUOF+67wNF/CG97AScUB3Gw1AEs0pfWbuFW+HpfzrdjHSrgi1IgykTQ80zsDome9H0mJNJH
	6JMMHTzMozqV3abgFVqJX2Ml5uAvSZbLoCqXKgaV+dAQOTFzXtpaR/wPMtCMTD0BtXpeuoIbHIY
	EXwvCyEafoVfEZibRiPEhrzFhuSo2qvBSMQhiz38F7QrqSCciwXSAxpsKgdVGTibC4fVr60bJpq
	idJCwNfzWGSKPLqBj2BdaIzVNMK/PA9fqHqJkXDIUXyqOh1JBxwkYadtV8FXdY5A9mxECnlFeTu
	Xu8jX7ESbs6T190pLV9Ih2
X-Received: by 2002:a05:622a:22a9:b0:50b:4b2f:1606 with SMTP id d75a77b69052e-50b80c9ad0amr112829091cf.15.1774542878294;
        Thu, 26 Mar 2026 09:34:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c091:500::2:e5e8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e1e6sm34113941cf.17.2026.03.26.09.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:34:37 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:34:35 -0500
From: Gregory Price <gourry@gourry.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v4 0/3] pull region-specific logic into new files
Message-ID: <acVgG5veOwDLnY9X@gourry-fedora-PF4VCD3F>
References: <20260322131638.3636725-1-gourry@gourry.net>
 <69c55e9b11465_1400331005a@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c55e9b11465_1400331005a@iweiny-mobl.notmuch>

On Thu, Mar 26, 2026 at 11:28:11AM -0500, Ira Weiny wrote:
> The 2 patches below fix it.
> 
> Ira
> 

Probably i should just fold these in and add a Co-dev here.  I'll spin a
v5

~Gregory
