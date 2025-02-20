Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EEB264625
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080160; cv=none; b=WpQ2/HQa6qRrAJND5Jfi8E1/RvMkWeh0or0WKlFNsECKAFgjueuABii0OvxMgsimQ4WcFvRshf+xyeFpWwQ8633aLufDQO+vPVl12ehiBg/gwNkCVEj8JpD7jbi7q2I1QWeLczLTwyTiW+AtfrGrqNZjBohjWs10W4lOU4k6Ou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080160; c=relaxed/simple;
	bh=r9sumPUkFDAwd49TGJqDeaX3rB6YkrFT+aTeUwfTG8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwRQph57B3xr/2IyLDhU693nUI1PpelHH9Nxf0TJDud+D3/SPupa5fZF0nQFc1ETdFhbOIR9L78CImewipyapHZSikOPqSh0sMfoBX13+vlgXYxhkjrAA1yXQKbcZs5Z44emq+ORiLCanv9g4G1KJkks1hJviTM00jUpo2Fu4f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=P6q3WhjE; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="P6q3WhjE"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0a159ded2so130072785a.0
        for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740080158; x=1740684958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aq0auaV2gz0U2k7ZsV3xhtnt/Z87hJ6m6ZAx0KCC4ZY=;
        b=P6q3WhjEO/55iw+vaIfRatEQB8PzMI7Sbdu9qiLc5FG/+cLwtOerlJFRd9OEK+53Db
         7occM8KGTcT3DIMS9aL8TqznfurrCJXP1zCFfugEaUWK1cAjh3Nwn4X/Ru14M4btWkge
         LWf6bAA++h1G7lU3GDXjMUni0yRXV98FBb+i0qShXvl0LSnLiafi8aPdE4hQ0sQhfPDn
         15bIuL3wVrsM4kmYIo+xVdHsbw4+mfIQQhy8Ktsj8yNAX0sCZnePVMElM+tl2JrlkQQc
         pxaGudevsXhv2zxpcWJu23TvpheMiMFawHZUYuA0nHfVQh6IMorT8PfIRS1hzwTXTiGs
         nIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080158; x=1740684958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq0auaV2gz0U2k7ZsV3xhtnt/Z87hJ6m6ZAx0KCC4ZY=;
        b=nNkFFU1QSXO+KmcjLPDD/iVOi+haWvXpXw2fU+mWsDdmx9wgkCdohGPSRZVjMytxQU
         tOhuHy8xyr21ljh5ZOH65Usnmpss5Nr43laI7FgqNsNCx6IHHVWVviXWNyHKE9tDrZS+
         cNkLn6jqoLTgCdhFHIzZzdT1Na6aQssJLnr66VWTL/aXJ4gh1i7YZ5WmfBbrw6pr1ziC
         b6i/wR6QHt6150gDKHfk29Uidch2EeI70Af7oX8CHoAXbeMSpwAe517gE38bX37fKyLf
         TcnedHstMRKMCYPS3dg+VsjbLnOssushmKIaL8bnugxWB8JxSaWOuGW8Im5g/tEiKfut
         fwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVma/narNAlU8SId8pUTMMsgryVPFIapIkcpiW41k1gNPpQhFVhMMW5Q2lnHKIR+nsa4aWNIv2sDiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBvHiW556apurHQ3EHrEHN/kKdkl/n7G0iScI49Zif73UHzCT
	9aU3xTPoas96kd465cZE4wxE/ShjqsFHeq2R+PtzXdhrTkok2KGIEMi5JlFyY+g=
X-Gm-Gg: ASbGncstTVwQ5xKC0PlSXDrjd4m2tecmCaWUbYhGGIdi8bDCxQcFEJWyX21iqwsL+Cu
	EO2+nJ+MOvPiB8gA5yGgyoF0vK2a8AgRTEHkGdg+1g6tSxhFdfsmFfZL0GWVCi+bOGJ2kN0WuCD
	cz14a1Ce3RTNjfE+DCHckdE+182cfT4hsGKIqZsi4YxXTL5EGWvISOPNFLwAU1XZPXgx1UxC+tk
	0ryP3+fkHZn3vCRlmyq+RVIjA97heoi22z+M6ZQ2zSYUfbA453z18kY6mlWioNL+w0C4nzsbsfQ
	qerIDZ+Tgi/O1PG0zQX7wCjp1I+ZYhILXGuVEwpzksXfn9v4y80PPa1uFuJy7wz4VkfU+BKM1A=
	=
X-Google-Smtp-Source: AGHT+IH6lIxZerlRr77ih8We+DvTCu5urzGeLg20c0jFu0pBr5a/Hqe/QBdSDGwo66aHfXOcSlUTMQ==
X-Received: by 2002:a05:620a:2444:b0:7c0:9f12:2b9b with SMTP id af79cd13be357-7c0cef53633mr82056685a.35.1740080157909;
        Thu, 20 Feb 2025 11:35:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a4430sm89493726d6.65.2025.02.20.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:35:57 -0800 (PST)
Date: Thu, 20 Feb 2025 14:35:55 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7eEGwFltjWaoX-r@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>

On Thu, Feb 20, 2025 at 08:26:21PM +0100, David Hildenbrand wrote:
> On 20.02.25 19:43, Gregory Price wrote:
> 
> There were ideas in how to optimize that (e.g., requiring  a new sysfs
> interface to expose variable-sized blocks), if anybody is interested, please
> reach out.
> 

Multiple block sizes would allow managing the misaligned issues I
discussed earlier as well (where a memory region is not aligned to the
arch-preferred block size).  At least in that scenario, the misaligned
regions could be brought online as minimal block size (256MB) while the
aligned portions could be brought online in larger (2GB) chunks.

Do you think this would this require a lot of churn to enable? Last I dug
through hotplug, it seemed to assume block sizes would be uniform. I was
hesitant to start ripping through it.

~Gregory
