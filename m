Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5497175A92
	for <linux-cxl@vger.kernel.org>; Sat,  2 May 2026 10:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777718927; cv=none; b=uObdFACBkGrHMF1qECvKDi2bScOc+V//IpZW1MsypdjJwS/kClNJGi1tF/5OZzKqVpgDB4Zmgl3IZPzwCG0OsrMJmuhL1+MhW/7Q7+lxeTFXgEnEperAKdG1vi6azwHT3qDrE3vfwbr/lLv/KrPeO0R6ts7I3pSL73wnau8R2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777718927; c=relaxed/simple;
	bh=9l6RBQkFfSATQb3fnM0uNRz3ObBEIWFtqkXWPVtZhw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7q+xP4WXaHbPAvOJ2gFUZDazPzrs7yIlGj06YacMqobfiOeL+i4XSOhGpVw/+U/sVUYFP8rvFeJ2bmhUlI8UNWJNj6DrsUz4cZtKetobO+TKCmXxFo7ViVhdgZbgtBgb0Fw3fCpOvVDCHhT/qWyO5dgoJgvMAG7ot+3ShTecFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L6adCl+f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L6adCl+f"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-444826c16ffso2396803f8f.1
        for <linux-cxl@vger.kernel.org>; Sat, 02 May 2026 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1777718924; x=1778323724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bX9tRgr9mQ6ozEX4pk1mI8lnk6xhP9Lqie4fOYAHF8=;
        b=L6adCl+fsSjrcKs1MT8gG+QCGQhLz3BqwvaKzfY2GiPdYZGe2kWaNzLBwxcKu4VFM7
         E/uWozrtWv8lwAHqN965yhPwT4OPpgrVcgvIj5X21DK80wFakgexw2/aUXK2kd6Lvt1Q
         zIePh83355FeqBOLOJGTg6d6kRFchmfTnrAB+4gZtD+B5qcyj7DDDUUEQ28iUZLcNfhn
         764B5vHGfI2zSiAbIDvrw6vFA+B/74G5G3pxK07xiVL0pWs9qLPM9Y1RLXHMZs1FDMaR
         kfJvsesj8XM8/+CV8yxhQH/zgr1g3QqRJAj2lWKdJ+LdEZmnW3GcAFpWf5JKeDBYhVCv
         06Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777718924; x=1778323724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bX9tRgr9mQ6ozEX4pk1mI8lnk6xhP9Lqie4fOYAHF8=;
        b=CMV08E8zSzrNir20j+lNlPXuu7xFfT0buvHn+t6TcKxofW49Zte56Ivu7ZeXQ/56Zc
         CmfhHmIG6Gy2SOO6u/JvEQczHJd5Xg5Gfs9uXz4ym4D8DvRTURVpHgfcDA3exKB8EhPd
         g5K41THxX0Gym5q/JZYT7G965lYGOccIMvw+rqH1ij1ZYPWFL9oAkG3uVWw9Mx0u6cpY
         N4WPqdmd63b6wJJjVBfzfrR+O0BmPSVMm3TKwiMXg/fNNqYBezr4OYX+2nDj65mfMKhI
         mJ7sZNOQEFMoGRlua2BlhmmNbCPb0L3eocCoBFN1vL+382ZTeuZpP6MwL5mqWiT/ZoXy
         N/PA==
X-Forwarded-Encrypted: i=1; AFNElJ8//7hTZxY0r/fROfL9oqcLHY0NTeQ/5r5d3kpm/a2H3OXotUiSmOn/COMwvZcIhFQH0+9mD2lgWWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6b15XV1ce8yOVcE/g2RR+M7ovLWPF1HfW5aIVPNlhURISvZsi
	EwAF4d+4kCgVjyG2qWjdL71N+QDRh7UxcwzWsn/kDgXBgnwq2ZN5a1f+wDvII/DfoIE=
X-Gm-Gg: AeBDievakz9WgVML0JzP/7SVhVoMq0mJ062FEXbP8SvNCfRfrWcscxXZcxHyMtFyuAy
	Vovys0H2z0fIKaqARUuSfW+jZneT9QVjrEuNPVQaoenDycopDdBVJIuO24x7OajL+Yesa653skS
	gJIfXp0CM455z49t0fEVfqaaN1DTWOghxhHRu1lH3GhCJ8My5ermHs3+OLDA3IASw+rPbVxrg8/
	/nR5M80AgrxjZZCsFiQm1eWannrt7G6OaWtMuwSNfddqagiN0J1t1cH1Si9GR7uxBrNqeCwg2ov
	nQNKSWpESE7+3ILDdqJ5hlbVD6AnMw3wjHJI1gjxvFL2gyI08jW7t7cZH+JO1eTJ/3dhco+uAW9
	re/uL4w9ysaYCbnKBkWI74Acdle9Jix1kR21C19AMMmg0y9gCPVI3jezOglK5f2eo8e+Ym345WZ
	7hm7FPll6/e7MmpffCThfVxlv5mJHLIsQ7589jfcmgCxu+vsN4rqYzPxM=
X-Received: by 2002:a5d:50cb:0:b0:44b:d21e:bdc1 with SMTP id ffacd0b85a97d-44bd21ebddemr2401445f8f.2.1777718924098;
        Sat, 02 May 2026 03:48:44 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([213.122.39.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cfd2sm10427246f8f.2.2026.05.02.03.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:48:43 -0700 (PDT)
Date: Sat, 2 May 2026 11:48:41 +0100
From: Gregory Price <gourry@gourry.net>
To: Anisa Su <anisa.su887@gmail.com>
Cc: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>,
	John Groves <John@groves.net>, Shiju Jose <shiju.jose@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>,
	"ajayjoshi@micron.com" <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 0/4] cxl/extent: Enable and validate multi-extent DCDs
Message-ID: <afXWiZy3Rp16XF-G@gourry-fedora-PF4VCD3F>
References: <20260423235108.3732424-1-john@jagalactic.com>
 <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
 <afUiZ27UtF3589IR@4470NRD-ASU.ssi.samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afUiZ27UtF3589IR@4470NRD-ASU.ssi.samsung.com>

On Fri, May 01, 2026 at 03:00:07PM -0700, Anisa Su wrote:
> 
> 4. If we allow non-tagged extents (as this patchset allows):
> 	- can non-tagged extents be partially claimed by a DAX device that
> 	  doesn't have a specified tag?
> 
> Ira's original patchset introduced minimal changes to DAX logic. Introducing
> tag-awareness to
> DAX resize logic may require adding more conditional statements, 
> especially if we allow both NULL and non-NULL tags (but there might be a nice
> way to do it;
> This is just my initial impression, I haven't tried implementing it, and I could
> certainly look into it more)
>

There is a lot of confusion built around tagged vs untagged.

Can we at least agree if a DC Extent has a NULL tag:

    1 extent = 1 DAX device

And we just denote that a NULL UUID is a sentinel value ("Unknown").

e.g.:  there's no such thing as a "partial claim by a dax device".
       either the extent is tagged (part of a set), or it is its own
       thing without any identifying data around it (probably intended
       to be hotplugged as system ram or something, userland problem).

alternatively:  do not allow untagged extents, because we can't make
sense of what to do with it.

~Gregory
