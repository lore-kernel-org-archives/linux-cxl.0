Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641B1799F
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949144; cv=none; b=M/ZYcv3Ph9iHV7yuw+r+hOZwcmyd21SgMbVMqGOkIekBKSg9flu79hZqjxVAkldx4jIlxaAKvJ+UaN3ExDSr/Pwgr4Bt1NZcUdpR8ZUQZm4vdehMjnJEgNSF8K3hfHUsd5TRQjXD9ejkhIA3bAdRyYwrJKISMiUexGBve41DdCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949144; c=relaxed/simple;
	bh=26IIxDaU8tKz19p8HraXCpcoHbk3xASv4Rlp7MIbuXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usndbgMqaFVnDz/tSunuZJMJTimRhdjUhkK0KeQW+iHPQeRIpOXb7wuJf6brnOk507V3jys3CRhvHKt8rbhVBGtTdItkbi0hCyye3YoIeKDiIsxwHNhrA7TFkfww09Cmp7tnkUnmLv2oHXMBWGMK7/9jQv4KW0f5oG+5GpK1PmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=vKxNmIQo; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="vKxNmIQo"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-899a615825fso11302006d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771949143; x=1772553943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tg87bi6iYUsxLy0rvyJxoz56n9hkt9Vi7pVc+cb9v4=;
        b=vKxNmIQoQtywpdHqiAAUd30hnskT0NcXiwLp2ctrQ5OAk3bo0M/UkWq3LOJ8AnvsDw
         QDV7RtFBfDIkIlIIL+IgZUiPd/8wMMXfrr84Y3P161iAeG+m68d9Xzz7DwD3IMC2XxHH
         CZvhZ7D5nYIrYk4AzhgKVwzMeOlTqHZB7FMWjo8EszPiERDbG6ov4gF9frrwkJLkLRNv
         hNQh7GPwDgNEIJAV81j6rc6ZSPAcTJmnKITJ3PocnU/FGcV1sYnTq8opuJ7cifV4/6Fy
         Vqg/cm8hRd3ME6l0fAL9pNAhQ/iez4znVMtCZL0d2ZWI2U/hmuAT9hKPnI8k1oG5AH+9
         MIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771949143; x=1772553943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tg87bi6iYUsxLy0rvyJxoz56n9hkt9Vi7pVc+cb9v4=;
        b=rrih2W9I7TyfdiIMjIG+0Z4OyxU1IofjzzdyXk3y9qdwoyRjbX/ofpi/XQy7lH8FCk
         fjP5g3T1HjHaJq6PHri1VkWyKZGlPI+tGVOlmeq295M29xj7PjwYYUifQU6qsHyRpMDm
         ojp81Myb4EN7eYk1yCIDUkB5RKQdPSjg6Omld/otK+c2lXda+l3sCAVprmk7W+Goanim
         5yUb4cxMH3ttH7L0n3sGD63Ckj8YIIVXOW+1eOSAcYsiodaAp8SVyEit9SvVdX0QQ1lP
         WjjeTThT0F3XIDze29jqcONm50icOIo9/sqGFEkCh6J0e/2bc2/oPe6O+ptsWMGBsD3R
         CG9w==
X-Gm-Message-State: AOJu0YxxUhjBFOUSbVag/55s2ZXyfv5baSowHquiJg+o2+nRNWLWnfVi
	yctN/t+JCQavdhQ5oh7Qc7RcMBk7EQYOtDHWI3lv5iPIMe3/IqpdtNFj+h8iqxGcE78=
X-Gm-Gg: AZuq6aJBKgSWivZv1cMYF9Qpp/AEfdieC3HQWz/WJ4abWTpzF0swcarJpFi55R9oPPC
	Far84hJlxcnQJDOjUSZi2QoTcnGJE/2rCXoV12qvYGYbRtYlhjuLS9JIUGMFaPdfSfRl8gXnKpX
	pRLxH3BIYeGf9ZrFzM8UblgS1tHpK+VFJvFUyphtP8vxat3y08FlJFTprL3yOwot4gRaHf6VJ2T
	IC5Z+Z2yIqcOne1Hx+TQyBACokQaeIkAON4XPuYTNQjReMNbvZ7aPJBPvoo45r8+woy22s5/hQe
	WzlEt//MOyva06LHNogKcNc15Vi2wtQrxT0AyaqMYxbF0tAxGeXJsOBlDCFG3CoVP7RLng+XpkQ
	Hj8twtEtNBqFnrlFjyit8PmCT/MhCsy+w+HCq69Ix2SFqkZKQX9h8Fatn4a6xQC/DMWDRX1TsfS
	cjrkJxlw5+RvMfwJu99xIiyXMLQzvp/jTANXAychRJa0fVIF9bXJX1tJJeZ22CFgX3nLLoS26iz
	GrcAe6446VBBgym9nSr
X-Received: by 2002:ac8:5803:0:b0:4ee:1f22:3613 with SMTP id d75a77b69052e-5070bc94ebemr190256781cf.62.1771949141302;
        Tue, 24 Feb 2026 08:05:41 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6a2676sm95492671cf.18.2026.02.24.08.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:05:40 -0800 (PST)
Date: Tue, 24 Feb 2026 11:05:39 -0500
From: Gregory Price <gourry@gourry.net>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v1 2/3] cxl/region: Factor out interleave ways setup
Message-ID: <aZ3MUyOy2JgavERa@gourry-fedora-PF4VCD3F>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
 <20260224152645.3441489-3-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224152645.3441489-3-alejandro.lucero-palau@amd.com>

On Tue, Feb 24, 2026 at 03:26:44PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices is triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>
