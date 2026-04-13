Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F64A38D007
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114662; cv=none; b=fs8ur5D5EH5DEgCzoL2qKbm6hO5QurU4TxW4kLYRyjrMMprVqxJkjPY9d18yv32dh7l9HPqbbFPwDCsR4bmm8wIm5cpGkJNQ5R3USBeiqseDvNUq5DFCjVmBr0Ds+oRtEd+A6nUJ0GHbkHiVa7RTs0ESKt/O5PGSA288MBFC18w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114662; c=relaxed/simple;
	bh=Zu9Y1OZSUXOJVh0Hxwr7m8iJ5/WvQjpvGRGhPTQgKwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvbKNTb5wengqvenuPlYUsm2xdZW5wVZcWUFEmvD6CCQZRN1rIvt3yQtubttyz9TFcY+JqkCY5HmCYdwzjPjnEr41belLOOT0PtTILlcnYkVSFwVbbQwVO57K4XiR4Zh6S4IyLkRr3M/or5zkIxbwdY6Ood8JcJSIaP/ZoZag/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MbSLvqig; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MbSLvqig"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a7bbe9d0so39136691cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776114660; x=1776719460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvjBPb9V/1uUcVtqtPM38pzbO+uRaYxM6ZJ3cCtV8PQ=;
        b=MbSLvqigJ3bwIdRcTvME9dcJRW99krvA6yRRyRi0EhKWdt6B9ce3Sla9ei2lyQRGmq
         YleW6Yzz25tnpmLw26w4CUuIvhZfktAIWmBO2z8F3hBBC5StQxPvnp6r829i9YbbyF8v
         MHb/FdOlWFq2XxhR8A3NXXmG6iK6WRvCAUYKNuKLdqVQAls+Nb2IJeNMM17ASTZNorCd
         wrETQOml65bE0RJcdn6BhVtc4idL9VHka8iQcKyrUHSGswzl3zOJ2c28hN6QP+pzlxL9
         ot67zwJRyituSWFiNlPUzvrzYcvxfx2faJYVF6eTrRB7xaWF7JBWBwU/kFe3jXcZHxjo
         aw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114660; x=1776719460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvjBPb9V/1uUcVtqtPM38pzbO+uRaYxM6ZJ3cCtV8PQ=;
        b=Xc/wglGhf+08bbFU/JT+bUPz95Q+43BJAP4vk8Dkn7dXauYQ7/+mm83A3v4SgdgCSP
         ZWsKk5LpyzfpKHxH9ezJUaqDAOuDOn6ks6ws2nJXUgSFcoxoIM38PLqo+v+Mv505oKtB
         acVpnS6ILPH36Nk2sQrAywYI7SxOUUzKa6daY0czLkazzezxiJCWEKJWCiL+DEa2YYOw
         i3136e/J8KR9NCiIA0p/PUq9r9SR2NEescGu5fpE6Gvsq9sD2oFXZ6i9F/+LM5iNB+Xu
         ucHHe5kntmFieTRiqFjmJNx3f9VGRUTXOn7iXnKqQ1BhjYL7OPZyDb8CgMMvyEvd6cWo
         auZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Ywe04pM1fSGuIeribOgOzjYJ1SyNINaM+vBkyvlxGR513jl6k68EPDP540L1XPLlHR+5rhkHxGqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXxlhJFZXfiUeFUNfCxuBBrq5OKx8hl9/rqfEoD4NxZue+AeS
	9FviBfoOGA2uXb6sOLOVzbB7yRcOmV84IWHN6JGco8q0nHMpi+12h9sj8j+eSqbDiTI=
X-Gm-Gg: AeBDietQ3MrmgDbMqD89agvziwLiOi+y8vqZspf5+XkN0K1KFPXdDgg6qKxJ+VCx0c4
	6Sjz5sUCTVjT1uDdoqimxFeb9wZrlU6UzAIa5LHiuMTGqTGYsG3q74ofozlUBJnmWI0DVgtq1G6
	vWrU3cee80HElUDWl+Du8uQOw6UmZsMnddKj0edo2gAto3G8YydR8zF+vx8DgOil1pjWEMefbHf
	HUrgZnaC2cKh6yMLYwOGZIgbhYc3veM0tzaUaCWu8uEmAxlMYY4882uL/Un0CnHsIWihetzMkyk
	WwBKIpXsVtMpBzvIKuoMcW7B+krl5OdEcnHZFfMZ8LmeYx1+SPT7H6/DWGAuSYeXxRuZSBKprE8
	xaDX6BUkYcyHAd/eeBprxON5nCbtK1LL9jJRGCh1A1SeEWVw6o58UdJOsL+0x4GiVTvj1dXjLfp
	83jgsPPmCyTHakt50iBYnWnw6g7/9fzrvEZLKqWbVsymBXrGsLuDkLNLODVe9dGO1g318SFHJkP
	mrXV/1ispi2q3W2uJDGdfM=
X-Received: by 2002:a05:622a:8a04:b0:50d:855a:8909 with SMTP id d75a77b69052e-50dd5b7cca7mr167929061cf.32.1776114659953;
        Mon, 13 Apr 2026 14:10:59 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-71-191-243-150.washdc.fios.verizon.net. [71.191.243.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd54ff026sm94173381cf.22.2026.04.13.14.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:10:59 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:10:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Strategies for memory deallocation/movement
 for Dynamic Capacity Pooling
Message-ID: <ad1b4dVCgG27A5AK@gourry-fedora-PF4VCD3F>
References: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
 <20260413164359.00001c86@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413164359.00001c86@huawei.com>

On Mon, Apr 13, 2026 at 04:43:59PM +0100, Jonathan Cameron wrote:
> > 
> > So quite some things to discuss; however, not sure if this isn't too
> > much of an arcane topic which should rather be directed at places like
> > LPC. But I'll let the PC decide.
> 
> Superficially feels a bit arcane, particularly as we are currently
> kicking untagged memory into the long grass as there are too many
> open questions on how to present it at all (e.g. related to Gregory's
> recent work on private nodes).  On recent CXL sync calls the proposal
> has been to do tagged memory first and only support allocation of
> all memory with a given tag in one go and full release.
>

General consensus after last few months seems to be:

"While technically possible, untagged memory a bad idea for $REASONS"

I do not thing the private node case changes this, if anything it only
changes where the capacity ends up.

~Gregory
