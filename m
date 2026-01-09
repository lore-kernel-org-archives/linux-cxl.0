Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070B450095E
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767974912; cv=none; b=pOaDat5lL+00qEDdAV0y91PnfIeVXn3MNGIFtwfBnG0orpoD6i09mwDNB6X55yCojyRMKPlXn+OEkbq0Ll2S4yzVvKqx7sr0pQSl0AK85a6EoJQg5YgtM0nM1RmkOzmZfPi+KNX2mNqzobJ7x4a4QEgR/tM83OLWut1q4012Ubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767974912; c=relaxed/simple;
	bh=dDdBteoNYUbTfJwW87hxXDzBER4RJ3dbkkyRnQ02yRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rngNrdqmNxgIz0M/J0DHq5ZHCCxFyStBQ8rZVXlURiOD/4MCeUEpjV7rxhJK5X0/quoLC32UOQl+5WYhwL6FQ9FW6VGjOZ0+E5UML1qiIH80JZzXYGtWFaaLPhxA/Q1Wb6+z/xxfyfgMFyh/thtxUHXWQ0B6sRVhBfBwMLJuULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=R5ww8e+U; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="R5ww8e+U"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ee1939e70bso44918801cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 08:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767974908; x=1768579708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4vHEUNRYMXphH1rfrlOiSS0TJwDxNN0hMRXL63E6jo=;
        b=R5ww8e+UZ+9lm7KN5g63LME5bLx8Y5/4fUTKwLy+EED6VZhApFnMLxtn9wbi7qzSau
         EFPBKB3aoPjkF+zNjPsTyl2vaZ7hXh7gObBZZqgEAIoW3XaumXpa525HRGyos07tPEve
         hbBQTaYhRvcFLEfkOEm7zqoX2EOZBaXFwfnWlwldbT0rwl2NY3TkUYagcWVm0bKvv4i6
         z7CtBhiGsOKjgMRBy+unfOYQRGLcr7WXuND0Ln4aByAPMRln/8dYogt4SDe266IRf/2p
         XgswHnnpv2WF03zbzqr558zx6YZEsFcLv/4swSgap2Y1X/aViMxEAYH0zW9Ivod8mbu7
         w3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767974908; x=1768579708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4vHEUNRYMXphH1rfrlOiSS0TJwDxNN0hMRXL63E6jo=;
        b=qfW0EEOAfedFt/rU1Su+lWdoYaseE5FT0VnAYktSw1YKWbMWKhAUH8zgcF3hcQkXza
         42xR1omlLdOpxKaDbVjZu+DQafPf7tSgw5n4wTHm1FFJ2idwZZDg1yzdOc1nN5k/ub+M
         qffsIYC3F6ROM7tmJe+ERCLTeP079L6KQ2MHQDCFlvF2nitUdqjvnr/t6tdfKIjOxmbR
         ymkRVrtJ4epAEnkUMZJs1W9NZgc0fGu9w7dwSD6w8/1fYdY1nbtdTLxCGsZZPgCLNlqu
         s3LTEnlzj7mK5A9QSK2QBHPHZhqxfmyRqNWgCXH+mh7qfkJgGfDIoPUV40fiKGXEBLYG
         zm9A==
X-Gm-Message-State: AOJu0Yzs2mQI7kgb8e/5vfMLLLSym9cfKOhSp5Oy2bs5qwErL76Q6o7G
	eKUSZkmX7X/GxMeK04HRMM/o5lR8UmQCrTOB9NzLQhvcO9wz3cqONT7BKB4DK81SgAc=
X-Gm-Gg: AY/fxX6OD6+D406cKqZ68onCxlH83jUa+X3vun/Bd6b15Mub4pgH9+7CsQ6ZQTp1Cdt
	gwYBdORLDyhYE+uXPKSAZF2zvVd1QsdFN1wRPnB969oMhJKrIQVJUOmePXkXkQMuVflCEQOfCyN
	0aTb3In78bT65peuJu+MSkleiw1WJQUiiaPmCZ7reXpSFAxlZFO8ZC7HKcqS+or8kZCSPDNVgrm
	s28vvRF18mGVNc5hjWjiMuNn7BZ17AYE1PTnLBrZqa3VV8kD/6opnHnPE+a6KXuCwmQQbOJBlGc
	v2Jiw9hvuAxKl4xHofkMpoNK6/jBjSwQiszqozACu8MLxNyI1jQkJYMT7jx2umi+GSnDjOC8/31
	eFjf+QuEo71SGHZOYclH/6sqfIx1lW5jFlM+cs0o45aN4OiOVbKvZhpqYIxPmHauWKYPsBXjZnb
	2WWEd5Oibom2x61CpwK9zTsY2bb371LrxCDaGMBEZsUMz1VYdtj7j7T6Uh1pTX8SnrPos/ug==
X-Google-Smtp-Source: AGHT+IEdvXZpwW/0Rj/zKD9Q0FT8JfSOnFbEdErwx/lCsZ0mgwmxjheOk0MqApSu4txhmwbpb7cX6Q==
X-Received: by 2002:ac8:580f:0:b0:4ee:1db1:a60f with SMTP id d75a77b69052e-4ffb47d6537mr154025831cf.16.1767974908465;
        Fri, 09 Jan 2026 08:08:28 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffb75d7916sm57189031cf.7.2026.01.09.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:08:27 -0800 (PST)
Date: Fri, 9 Jan 2026 11:07:52 -0500
From: Gregory Price <gourry@gourry.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	hannes@cmpxchg.org, david@kernel.org, mhocko@kernel.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, bingjiao@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108101535.50696-4-akinobu.mita@gmail.com>

> +	for_each_node_mask(nid, allowed_mask) {
> +		int z;
> +		struct zone *zone;
> +		struct pglist_data *pgdat = NODE_DATA(nid);
> +
> +		for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZONES - 1) {
> +			if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
> +						ZONE_MOVABLE, 0))

Why does this only check zone movable?  

Also, would this also limit pressure-signal to invoke reclaim when
there is still swap space available?  Should demotion not be a pressure
source for triggering harder reclaim?

~Gregory
