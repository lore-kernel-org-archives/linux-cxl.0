Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7A12E229C
	for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987118; cv=none; b=ZMGlmPx6rk6XZ3qi5sw5vWN7E8XPr3WZqiuu0N6Qc0s8yNqzXxNrssO66KnwWnqOwwZ0ejMGCtCdHly6LH/lvYOf20yWoPc1aKfv2AMUyN1uRr/zb4ZgHjG91vHZqGbsXqEYsfqnwixleFtnDaOZt3GT4knmtNngu5rEH1mq8xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987118; c=relaxed/simple;
	bh=FGoy+1mf/iEZbqlUoKE5eP1goQQPVxc0Ioi3mVzbTLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXWLZQK7kq5X8OEzVQrsKtcD9l/gf/OXEpP8rN9hvUBK4tCkmziNx7Ubb0pmCk+qIRQm82TUlCcKyN0nOold4RNeQ2a5fONuNxlpruUKp3Kngpe0QJW/4FmuGloPiWglvrX+KL/QhBmhlxs6Aid3knjtb1kJBgL5HeF0HwS6vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=E49l6TGP; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="E49l6TGP"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88e51cf965dso22549785a.2
        for <linux-cxl@vger.kernel.org>; Wed, 12 Nov 2025 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762987116; x=1763591916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ILfLXbAJNiJYEiwM9cTPJzVvJxoZR1GJ61P0Au/eDQ=;
        b=E49l6TGPhXZT6EfM0aOToWidONhfJrcn0UfWWGZZDtgQCQKr+sdz61YFmou2PSRs7+
         uHB90aQLJitR4m0lsf0FcuL2dObWyL0be0AJcE0lmUcc/tX51z+Ocg9bOknXVN+jZ+Py
         FckM+3svCsiUuMSKMNtOAsbiVd5H9gug/f5B5exUokQYE3c0CHm5hrIOVmnbwEWT96ed
         4rVhy9Gk/E6fIEphFnoHPMTKSGidcIa65E70sISn+xxibmSJGGcQg+DDfQzSx5Wc0sbL
         8P9qDdpoE7wm2L1nJTxDFGsAk4u+kd7J5mMa8GWdBTeiLT/IjYk0LAN7mEzpyHh7ZsGM
         J0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762987116; x=1763591916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ILfLXbAJNiJYEiwM9cTPJzVvJxoZR1GJ61P0Au/eDQ=;
        b=lkNpqQ+kLoEoskRd6Zu9Jc438JuOqXwUfZuKhC14Bo25rj6ls9cdayMoCEyqB7KlJ/
         T784nlzArecm6yj8i8+asTFTzPacRYlVA2KjyjIyuAXoAYdo7H4bmnmke8F7OEzY8LuZ
         alWO9ZJCVs55ExPfzfcQ6oRhLwFt0dEQaIyFk3Kw/VN2pODDRLOPkiO2b4Eyqhe8Gsx1
         4NzRoq5cXRRmQUblZ5O6ccWO/udFHETAUoPpIoLrIt0jY6oh1/gQSiqe3T5bksDQJHob
         t9F6GWqI7FZ9vnvRiGl0IO5Sedl/0yGWAuweciD1o+jRI5qa9xFeETBdfDQNTfJIQ1cW
         aUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeEBD0tlpYBOgJ/oABm1z5GaPt25YnoDNqCjWa5p+TrgjlojmGlLO+dFQWD4dsViMAZAmg2Mr4sys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJCI7U0yy5Ht3WFaUeS66CHNEOdHE74s4cdFYRPOmFnvJkVQL
	AQLXQEpWUfARqVuiXjxW/iEz+qyiK4RbSIm2Mm5jaLrBMzw4KIzaMv6Z+hJJnGUdFpY=
X-Gm-Gg: ASbGncvRq13HWPPoOIdhLSVxMJNBK9roKTYAGXVs+NYZG2ZPBDDXRRG/Q8kIFmba0tt
	SL9sFi+uzDBMPEWEcAaTgDNvhItk8XyTHrcgmoKS/sIRPAsBXRQtAPiLbIbV6yr3F1WO4zlulJS
	wcDPWRknpf1B3J5Z3Kg1U0s0UjKN8JdNTNQ41+EVtUScBMc1JVbTr5OH1C+UmBFmOnrzZs6uo95
	tFh7QvwcipRYEv5cnRi1fsO324FDDodtTIcNxH1OT5vKUn84nzg2Dco9IutJRX3zkER3/cuyUNz
	O7RxULybN3sdwoTGJeuEJYxV/VQG1+jQewGYwtt/GRgRe0JmMx1c6rb77b18jHDWKjjSlPmhD0b
	YgVCN4BjkqgKJiZqPqmnYEI6OOoy3U5Bd4y6xfj1ElgpuWhKaSojnCvSz+sYrZ2LupXm4hBKeL6
	aIBzB1CGzT9g7ymxc7jaRYKxTWzA0gu9sarxWvH5/ksGWy/EzIaH2NROQZeQc=
X-Google-Smtp-Source: AGHT+IGs+xKxGG8LfbNME4hLPEzsboowTSnj+CXqHzwlqSKbwOsCtnyf86uAwOtcaA/KTC+/iIu9eA==
X-Received: by 2002:a05:620a:2911:b0:8b2:294:1cf1 with SMTP id af79cd13be357-8b29b768961mr649526185a.29.1762987115831;
        Wed, 12 Nov 2025 14:38:35 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aee9fb7fsm11841685a.1.2025.11.12.14.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:38:35 -0800 (PST)
Date: Wed, 12 Nov 2025 17:38:33 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 2/3] cxl/acpi: Group xor arithmetric setup code in a
 single block
Message-ID: <aRUMaWmN9uKMdY_D@gourry-fedora-PF4VCD3F>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <20251112205105.1271726-3-rrichter@amd.com>
 <aRUMBz8wl1ePak8O@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRUMBz8wl1ePak8O@gourry-fedora-PF4VCD3F>

On Wed, Nov 12, 2025 at 05:36:55PM -0500, Gregory Price wrote:
> On Wed, Nov 12, 2025 at 09:51:03PM +0100, Robert Richter wrote:
> > Simplify the xor arithmetric setup code by grouping it in a single
> > block. No need to split the block for QoS setup.
> > 
> > It is safe to reorder the call of cxl_setup_extended_linear_cache()
> > because there are no dependencies.
> > 
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
>

Sigh, sorry, hit the wrong macro, DJ please drop this SoB

Reviewed-by: Gregory Price <gourry@gourry.net>
