Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9012B21CC77
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360382; cv=none; b=hn/ZSwN9rRzCbZr0ypEO6zHWc0dVV+HLFUlJzM+2NSELnDvnbn02DeYsyXbn7V5BmgXauXvPfsU9k1QQeZIgl5afVXMVNpWlWr2qUwzizXDnxkzIUTwhaAjMKODXBhYlaeZaJtuaGZsvswBdUwxvJoCb5yJgcNotdeugkya0h+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360382; c=relaxed/simple;
	bh=2wMX+dMAk5OZF+yCTsbRVFzfhhV1PUCth+hni04YDPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIYqAgFIbqcLZqFQgeIVHzzh29ZRIA8ec69IJhglphIopaKndwd25pniT+KleNUiqPq0jiOf2OawR4+ZoAFc1M6L9nAnhnD4ug9c2stAN+49RwpfsIIGdEN5amdUUZnnsO3y73ACl7R7uLG9QpevH6kIwI9nsFvWJ1FXbtM2Jg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AO77NOoX; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AO77NOoX"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3cb761402so384513985a.0
        for <linux-cxl@vger.kernel.org>; Fri, 07 Mar 2025 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741360379; x=1741965179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vNr4ntECNtNIMvxVKv6TWdyQSFpn2hDLZaLcHO+bzIY=;
        b=AO77NOoXJBfPlExQuRnKEaWsOzBdXm2Axv0DEqDZChBcM3Cl2RHWDm48r1SUg01GO8
         qLA9aY4bqaF+sx3JToR8HCG9sNxqQ38GvYG8HyaEl/TczLRk3CedFkH5Ke3qMq75M2s+
         iaUzR4t7shhI5Zzm5Dvs4Dq7AOPtUUHPL0E+ybyYgBhS2n9R9jgJGfFlV2Gt1vVtDWkT
         Q+6GEi+6O/GboV+iLJMzY4RLQDFMBBIiMoYp7f8zknCVd65Mb1gDrCWQd3or8Ui/8Li0
         KKAeu3Q6X3z1boDBxJuogIwhJPIlS+cKhUmmi37W2AbPAdt043GBaVMG98GHvq2pkRpJ
         9FNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360379; x=1741965179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNr4ntECNtNIMvxVKv6TWdyQSFpn2hDLZaLcHO+bzIY=;
        b=C9PiciY8yO8UJiSUkEvz5AMblbkC9drl18cHa6OJYlP8xbSCrp5h00EvcmM71gDeJD
         jRMoV5sYUD4CQLJ9R7xW2FiHOvY3cFufZWveDsrfL7mvFm7AJBqw62yp878P1u0UAFJp
         EoVDLF2idwWyxxkmNKoY35TGxeTKyRHpiPyE1EL+edE9QzyRz04e35KLmfAiwBGZtz5W
         C6mLmaoOeqJ/SRq3pRE4Y+fKQOJlHTgFYPd3P17gw6U2Z0cq3wOdXpYpCAH7YH2y7L0h
         HGvKT0V47J5xeNUX/nun7Zwy3HeqMFZ9KrUeVg1RGl3zqQDEiVzmtHEc5intbWfuBx+x
         VPYA==
X-Forwarded-Encrypted: i=1; AJvYcCVDVrKGaZ33jpTCbbXqCDtuVyxFSdnr+zvn/ymDeHyWFm4eCijZukL+yTppUZkRuqImFfg4WH9IYyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgX58s8fRQtkamPocAzH1q0oscjZzWPggjveevJylJ3XwsCRCz
	qF+uC3SSPW9mMqtEmEu9ttKFg+79hYlIik3A1EpdUbgaocHBBvebtO6BWlZSI50J0rQpkxRALSh
	f
X-Gm-Gg: ASbGncsLvg+niYXuGvcKPQd2w9h/wPaBwW9MttcXARSEFb3UEPdy/5ll7nBOzg3V1A3
	WDrvRepsOBXkT7peRYcW5KrdvxUiGUtOO6DMaGsB92+Eb4/61zzlmLRnJCmTnaF+NyfH5yfsKFA
	jFOmK9jAjJZCaTs5eB5fNDeWIkuNAmYT6cTic1h8Qmr7+1BIWkQrNk5VN4Pl1IFlLsUdyvQlZ1G
	Mh5aB4k0pgOeL6yg9/16CjtY0r8Ap5nsdBxfafQR/W44khAktTn5SmIxJ/q10ikB8ttgwUfrgDj
	wmDRSWvlCmgGP6uGq2E/Ek9HPVRv6y6IcK7vQtFldh3wh79rREhqVOVOhXZBqQPUM9taLHuwYJb
	4gecniwshntss6BM2ua2ioPYHOh4=
X-Google-Smtp-Source: AGHT+IF1GDg63LmfyEarUB00FtiXShcOK8KVLiCcUDagJpfOb04hfBNYSrYPbaJ5e8IJKwahRj+kBA==
X-Received: by 2002:a05:620a:8806:b0:7c3:cd38:9be0 with SMTP id af79cd13be357-7c4e61ec9damr536785185a.56.1741360379462;
        Fri, 07 Mar 2025 07:12:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a9f9sm252426185a.23.2025.03.07.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:12:59 -0800 (PST)
Date: Fri, 7 Mar 2025 10:12:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 0: ACPI and Linux Resources
Message-ID: <Z8sM-W1F6-TIZcGa@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z8jORKIWC3ZwtzI4@gourry-fedora-PF4VCD3F>
 <Z8j8bZ5TS+gDV8+M@phytium.com.cn>
 <Z8nWobZXQwhtE1nK@gourry-fedora-PF4VCD3F>
 <Z8pX786s+1DQIMDy@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pX786s+1DQIMDy@phytium.com.cn>

On Fri, Mar 07, 2025 at 10:20:31AM +0800, Yuquan Wang wrote:
> > 2a) Is the BIOS programming decoders, or are you programming the
> >     decoder after boot?
> Program the decoder after boot. It seems like currently bios for qemu could
> not programm cxl both on x86(q35) and arm64(virt). I am trying to find a
> cxl-enable bios for qemu virt to do some test.

What's likely happening here then is that QEMU is not emitting an SRAT
(either because the logic is missing or by design). 

From other discussions, this may be the intention of the GenPort work,
which is intended to have placeholders in the SRAT for the Proximity
Domains for devices to be initialized later (i.e. dynamically).

~Gregory
