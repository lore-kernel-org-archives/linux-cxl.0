Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71103287518
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449042; cv=none; b=tAMMwHuW4ihpbjuhSHyGa9Tj4dcvPvZnz4rkBiC/p1NBhgOZVlzHlmIZ+OVQ/dUUIvT4EC7crjLWERa8f2s/5H2t1vkaKXSkvl9sutKaFjufES/nOD21iGeLYS5Mo/D8/ZobtAEieEPBEozbL6wkbeYKpsRm0du4ePGRrWjs1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449042; c=relaxed/simple;
	bh=rmeHfsMzlid1iyArckNbvRmnPpqtRLYF1zEU/JprJyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMNeobqz+o8fZgHK2EfxT2CcyolUOebZPw5jHoxTSf5e2hN9eYHsTcou7Pd/pitNn4gbRWTGhSDcXXGibJmeXlETUDwKlliLARlZ2jwjBaw9JIQrimLFINXx4saxAupP9EuvGyA7GZeymf05yP4wPq5CeE7ktsRaCY0omYjhPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sT7QePjR; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sT7QePjR"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed66b5abf7so27188721cf.1
        for <linux-cxl@vger.kernel.org>; Thu, 06 Nov 2025 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762449039; x=1763053839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6btJcIEuMjid7L88n76y/6zshxSUDozFJlS4QEWuRv4=;
        b=sT7QePjRmMqOrFrGMVy1xi8DIQbuEcQY7oq7mw61skdO4SW7RuWstR1+Qmtsns0joI
         h/BTr+eSS5bcJJPuDbMHWfoFHonxbw8R4fld+O3QrU4DtA7tEsjmTCWNxhlOV1I/2N+l
         yu4XXSlPtBl71Cx5lXEP1Yq1ZFyvuORNUp5vBA7j11tUCHZ+Xz37PHgH7R4vWM2z+Wr7
         xdaRymL3BjihCPxKFU3/0VlKhPQUHj8uIN1syzLPlIEzsKJvwhgnl5F3wrErLTnc+LH7
         +32oVZzZyKfaN7kZ+vaX81/UbLNxhQJASzAF7Z1F6flq+NJHFe9LbKAcRiLlHuTwlmxM
         3AqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762449039; x=1763053839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6btJcIEuMjid7L88n76y/6zshxSUDozFJlS4QEWuRv4=;
        b=ZJuXM+TrjT6Z7tsq2Vy2gGcFE1VKnRfN8cozQi7/q3b8VfxLK1MyQ/M7X5VOX4GFNV
         dQYWegME4ifa/HsjBHbL+1jClFEgr2Rj1UEuwDt/AVUywCahd8CM6yj/ZH8KigMWcJVE
         UaUjxU/2eAY3elP/JGeRIERF2KLfsDBAQHTNJObVVgOrta31166R5qV+A8rAPtTMN07B
         GWKmiDcW0FzX8951GsvvkXSY9VYqc8BVR0FhKWzJbsfVYlfWXyD8dt5K6Qc4Ws+C0Cbl
         l1xB9Oxc2UqN08TdLuQL5INTyEaxIe7ptVpH89KsI8UuRgv8TkKGYgfkRnLWZ5voPLIE
         F79w==
X-Gm-Message-State: AOJu0YyUhx9/Iz9XdJbEZ2CFNtCPOZaoJKK1wmwAjE8zjWS4EanJlV5v
	HuWWk5V1wmGTdjrklbQvI9qx8ZSyllpEAIdT4S/shYIT9BdmZ8zhC4XKt4dF7XWGkVk=
X-Gm-Gg: ASbGncvhRm/6SiI2YcJSxV69MjT7wE0klVTrrD95FMwvYlnUF3v7xX/HmmoZON4ag4h
	MwZefxaUHf9AL+wP7/WotJuDVr2CRS3+IOowOWN3Dxuu4EWcucl1KZy6d+1IHNFFQ7FBNkX3V2B
	SOaQv7oBx8JSxaIlZjLSAEB6fv34N1hdKF32jEMsLn/Si+/SEdQuBOBWpnNzi6GN25DdbtOwN6+
	hp36JyzANydMmPbmA+G6QfWjgpRXEolG0DIO2URciS3VH5dndI28wh8loe8uPmhhXdNfKQCyK1j
	Rp+eBsxWj32Fxyamx5qfFn2Evm9BK2+Sr0R4XChbf4T+kR6AORj45NEHYQZoBPdDxIAgimpyRTW
	SE/9UFQOzvtEqwHWaPCiGIpwNgl/Ep3n5Jnq2j/MREwhqK7wflEV9hkM520oS+32jhaZzyWEq24
	6UTMioIbBg12OlzbX9DrQgLhrZmsS3WDpjXf8LoIi0QgG0Yo+0TdqGmeBAsKo=
X-Google-Smtp-Source: AGHT+IGMD74RrqOAjmVZIgh0aHpGJ4SsG0wRkZd5oJt+BMqSzZaNIpzklToeDz7rhpSMvulWcy+Mqw==
X-Received: by 2002:ac8:7f54:0:b0:4ed:181c:297b with SMTP id d75a77b69052e-4ed93a0a583mr4015791cf.8.1762449039075;
        Thu, 06 Nov 2025 09:10:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed813b6b9esm21624571cf.22.2025.11.06.09.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:10:38 -0800 (PST)
Date: Thu, 6 Nov 2025 12:10:36 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 2/2] cxl: Clarify comment in spa_maps_hpa()
Message-ID: <aQzWjOttMB2eCQRh@gourry-fedora-PF4VCD3F>
References: <20251106170108.1468304-1-dave.jiang@intel.com>
 <20251106170108.1468304-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106170108.1468304-3-dave.jiang@intel.com>

On Thu, Nov 06, 2025 at 10:01:08AM -0700, Dave Jiang wrote:
> Update the comment in spa_maps_hpa() to clearly convey the construction
> of extended linear cache.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/linux-cxl/68eea19c7e67e_2f899100a8@dwillia2-mobl4.notmuch/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>


Reviewed-by: Gregory Price <gourry@gourry.net>

