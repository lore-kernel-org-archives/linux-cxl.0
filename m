Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C941189BB5
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747113230; cv=none; b=EdVcMWnWc+QKr1kBroQxbDeNGLrudQx4t9N4RYWrgRo3scFEGY66m+QO5S/mn+w0ILKzvLYSZaTQ5QOIqkk8lUU1yPkcBmM/zBBWjmlkmxSUWaTfua7lm3eleR/OZciLJvHfgbNlitG0aWO+LL7Y4gmT1ZohIoVeOhAM8t70EmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747113230; c=relaxed/simple;
	bh=MgzivQho+Yqe8CTXyGpBQXt2WlopJu5xbjOMUxRg8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsfrwitIWTN2Bm45zhpI4ZnLzn1hD6fZFJMbO45kVmthiTwbDGGF+1f/+Jk43uCo6oaGrtc8Me5wR3ek6sJNldDm6ZInu0IzHmqZ8bjzWlT165V0pEH+rOWJmtn7ZlQwv2m3illQBGwoFlnyCHjXXlw4GPmUOjSn2Mov6NuuPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TWPx5v1J; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TWPx5v1J"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso51236276d6.3
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 22:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747113227; x=1747718027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uS4kUHCocCoBpR2COqxkBDPVRaOgYa2RJW3YbfY04LU=;
        b=TWPx5v1JO9eWUCPUuHPU8ZcgCaVf6lX/e/9OeB6jJhv2LWaXx2fOEv8Pr9gDd4OQD6
         aIz5DnGovK7hw6g5c07OVXbt3QPBr/hkhTHRK/17+1fp9/CohFamimbcGUG4RR0g3duJ
         1ueN+5D5nrW7ZRXAaIviQ9K9jGulPxSPOlP+PuokYRF+Q3Hv7PYYIbYObUOQVeWlh387
         xg3YKp76lLtbrtIAKnax2O8rBvNm94MTtNe9MzjUe++KJTzkEltgjzqkcFcK06qSTxGE
         GLXIdhl7I8QfYimwhnvdO7Qpgq2Ieg5VcEfPdmLU5murhOGIBdSCy02f/K/X0FK5LH4f
         k4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747113227; x=1747718027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS4kUHCocCoBpR2COqxkBDPVRaOgYa2RJW3YbfY04LU=;
        b=Wzfu9kic6N86yPKUlLtS6/frh87pkfGn8PpqRQlom+XcbOBWh0wD/rLgeRjMtr1vc9
         HbCxMzdbv49g4Tl+XI8E52pUu8WWmGwmL0g5VCg45LCPmwHyS4JM8c7cHyrDKT2Sz/P9
         95GwIt2jYU04oc7x/HX674bI8Gi3FJ4JVSWkGGX+9KlO1dtf3AuBgbkeaydTAapYh7sc
         XkKGU7RZMUpcLum9HGcoHV+Uh06e4u8qkJoOmyBpmQWzpnZ73lTOuprb+GkePI2egBZn
         0Y9xgHEinFDIovm2KgFQ7TUEozfJRdLtY2G1mhBR7E3KPvIW9LS7jMutu2XBxDMrYaIz
         v7og==
X-Gm-Message-State: AOJu0YzJkKvk7jnKhKprlrJ4KV5CpDasOChC4s+UaMxmGP0b6uDrd62b
	FV8nB23REQpriVbNV09tibR2mOEDMGGhup1rGXxO5fpXpCLJtTZykGyua/BiJII=
X-Gm-Gg: ASbGncuMQlO1bXorjPZ1r05RUUAUFvFStFXloCnUlOo+LM/f7AGiruBQnOvV+PZ8MlL
	Nfrbdx0rJ/NelcwNxj6a+8xUFy8a9/D7tS434MfoxL0sMGMYiCt9RZh53w25dTEmsipxvharWFk
	3AsaifqejmliNWnRjQcMNkCOYbYFJDQR6TAVH4ghVbPOdmvzI5Filpq1oqT5xoyF00mn6uQHdRc
	Um5khUEUffUvYIQYQFFGRRAKETacIbijAd1gKMn0GbAIrh594hQmn3cUTLV2OTL+hkirJx51ZYu
	Evnsz3VUG8gkNYsM6+KUTa/gbCm1gYswdavT6P9sTzP0tbTcL7yoUcIjlUl7x7lmWAFrlSONvyG
	zrGVWqb8I9MGv/BainO97Hb0cYFQPHU4=
X-Google-Smtp-Source: AGHT+IG/GH4igwfhZhBkv+4gEihjmiMIWWfZDaLYUjxfddERi+24CmETfKNFiqURchDM+dtMwn4f3g==
X-Received: by 2002:ad4:5bc9:0:b0:6e4:3ddc:5d33 with SMTP id 6a1803df08f44-6f6e47a91f2mr237630936d6.13.1747113227318;
        Mon, 12 May 2025 22:13:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a5247esm62461036d6.97.2025.05.12.22.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 22:13:47 -0700 (PDT)
Date: Tue, 13 May 2025 01:13:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 04/10] cxl: Remove adding of port_num via
 devm_cxl_add_dport()
Message-ID: <aCLVCRHNX2sag9i8@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-5-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-5-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:04PM -0700, Dave Jiang wrote:
> In preparation for delayed dport probing, remove setting of port_num
> through devm_cxl_add_dport(). Will temporarily set the port_num after
> dport is added for now.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


Worth noting in the changelog that the port_num is set to
CXL_DPORT_NUM_INVALID in the interim to detect any race
conditions that might rise from this.

with that

Reviewed-by: Gregory Price <gourry@gourry.net>

