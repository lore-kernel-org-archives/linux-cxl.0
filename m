Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB12798F1
	for <linux-cxl@vger.kernel.org>; Mon, 14 Apr 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645455; cv=none; b=D93oU5gdQ+RfseiBNOSCfBy9cBUDVdBrvurMKanhauqlAOq8wuor21AgOfQ5Ur+fXfooAl3zUreW8XG7QprEZUvsHSDFr/CbJCE3BN4gByr01MviuZG1VF9nHJaDC13e2VdATK5ohtPvzFztfJCmCqXwJ3W5oUT1C9OTcKlnCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645455; c=relaxed/simple;
	bh=d+yoQOiN5wPxaVA80igHIFjXFqll7cRQhIlK/hqu4WU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbtgKmL/Iovyd3YxSkfun5HfRlkoiciAxg4oBhtBALP07WZb/BKlHmpzUgln2PtQkEL7q5C9vrMJmj92v1QmeRaqDGsGBqdXMmPx53jMfNO7hRqNDPh5YYrsSgmW3HzWKpuu1+D9Bp4khbd+II3yOmYL6MGKHmfKNPTZZEe4M8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVvFoZgJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVvFoZgJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736b0c68092so3840081b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 14 Apr 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744645454; x=1745250254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MetnSWs0nq1ZKwVMm1SZwshOSb7iM6OHgwlS7spNFUA=;
        b=bVvFoZgJJPCb1dova9kDdPD7OpBtkeskwI7dCUJ5Drofv3Q0saSg4kRIfAbv8aIzpp
         3CG/TYGAf9KgDUcF3/GqInOqtEqkOiGjtukD62yed678kOdU/NSZHqOkQA+YeB0ZEgR/
         gB2ipypN717Zni29pWqGf2NDbGBCROOv+94QlqpAj9uACuOFmmtb6wx+edlhcLB1t6bb
         zQYFniMSu+3GN050nstA0f/R+2qa3rebYBwkE6gP7wAEtYgNmZFUdfC/QG0CclY7eD2J
         zD39+0r9Ki/Ck2hKnkrXKALVS5AAckcmvXsMbB5xDtqD8LiRpn7nT/RpzpvNrnKFLpvK
         yiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744645454; x=1745250254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MetnSWs0nq1ZKwVMm1SZwshOSb7iM6OHgwlS7spNFUA=;
        b=aduGDqWqvNrd2Y9OUlh8nQB5w2mTfuD/PwVmeK+Z05FMEvUxeltWuVSsVP8LrqnBaN
         8u9wvplKtsUB5Z3wNIv9CXoHFZbwwVgzbG5ZHYGJY4wep2QxrjsXsz1fIiSVyEQXgrsh
         f+OR6q+pZTtB7XdIZFsPXjDFB7mZN9XcQ8vCGI5IJVKWgnolLL8sbp8lcPM7Vo3MA9BK
         BlarkVlHIMoveHgw9cHNy61tom6JTOsgvIf864AyjWXbt75HmCzY3wtVR+VG74cDTwQg
         Y0Zrb2gAYPy3yMz4kUwttTqMvz3yRbMXHBJ0kF36PaXlCHN8dOV/jtyETmaFhi8R28AB
         5KxA==
X-Forwarded-Encrypted: i=1; AJvYcCWA3UiEWOqacf26xsAcz3nl+t5dPMJ42ICwmgM2M6ac6DFKS7YOilbU3h4ES3PV8Wcb/HHVN4CH/4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnucVnfmNsFOBINmKAV+7NpFqtIPTktsKr3hST2dIHVn/oNLp3
	obN5mPTi/A5fOekDKDJeGhbKG1XKvvPW4u0giFx+WaaNodxvQtJu57MzGA==
X-Gm-Gg: ASbGncuUCCPLMmHWF61Wx8ZT5uP6imjYC3oZvOyf85osmACeYBPbSYJftVN3zj/5YhX
	rJsd8c6fOEE0UVnBjv/sEoGJPRCCLPDoiTZbdPkOKvDgIq5P5Px7hdjL5uEx9kADSu4PbhwBxtq
	TRDv4HzcfOdw5dAAfXGahHW3jJMg0G0yKGWZEai1lR1DIg7HytOoUQOEjg4y5r3W4hCM7x+4Dl3
	7Zn7B/FrTA0uDq+kc3I19PbzGm22J5qAInnIh+VYzKgQ5pr/1hpMeCDVNaChUswQUXovrY6ooM6
	UAvFxCkdwo6GxcEpnKFN50kgp8L2y8TLvYl0
X-Google-Smtp-Source: AGHT+IEqcjxulOQzOxdwWrWqATGggSA8ehreXXU0YQ0R98Atb2/pn7p2pg1A4rxYW0oNMDj59tlPTg==
X-Received: by 2002:a17:90b:5242:b0:2fe:e9c6:689e with SMTP id 98e67ed59e1d1-30823670094mr18264782a91.8.1744645453550;
        Mon, 14 Apr 2025 08:44:13 -0700 (PDT)
Received: from debian ([2607:fb90:8e61:8954:1427:df6e:93c8:2b14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df08f71dsm11219783a91.23.2025.04.14.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 08:44:12 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 14 Apr 2025 08:44:07 -0700
To: Gregory Price <gourry@gourry.net>
Cc: nifan.cxl@gmail.com, jonathan.cameron@huawei.com, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com, anisa.su887@gmail.com
Subject: Re: [RFC 0/3] Qemu FM emulation
Message-ID: <Z_0tRwHNXD8idZl-@debian>
References: <20250408043051.430340-1-nifan.cxl@gmail.com>
 <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_U69HlC_aKLghwL@gourry-fedora-PF4VCD3F>

On Tue, Apr 08, 2025 at 11:04:20AM -0400, Gregory Price wrote:
> On Mon, Apr 07, 2025 at 09:20:27PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > The RFC provides a way for FM emulation in Qemu. The goal is to provide
> > a context where we can have more FM emulation discussions and share solutions
> > for a reasonable FM implementation in Qemu.
> >
> ... snip ...
> 
> Took a browse of the series, and I like this method.  It seems simple
> and straight-forward, avoids any complex networking between the vms and
> gives us what we want.
> 
> I'll wait for Jonathan's commentary, but solid prototype (bn_n)b
> 
> ~Gregory

Hi Jonathan,

Any feedback for this RFC?

Fan
