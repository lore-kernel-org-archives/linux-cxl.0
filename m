Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CF173
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770768321; cv=none; b=jDkYm/cTYjd/ZJVEjlR8VUcOKN8jjQ3X/OG0iHcnBb7igoqQZYD7ULRO29eFFo+piy/LmwQPdkVnhjKclos8LAjqV61oEdKDIAh64YkdquMQGraPdEZosQVZeDNZQaPYobPKpyGcTYk/TEt5mIIMAbVfEVdRE4pn4FkNx5p0T+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770768321; c=relaxed/simple;
	bh=JE2dKBi7XjAaVDF3fNWejFkjmnDxLKGQGqVwMGxUM44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD25rRbM36Btw4eK/yPuMkMJ1MAFY7WfS/KPxJfEoYbNXH3WsfOrgGUz991hgms2+er7a2tFafqNl8oTsu2ED14PvAc4dX9UsOisIGcvXghnlz/kPqY/B4DK8bGRJxZ4oQ+UCYPHrVptNoLoxeHt222QE3ReAf5MALrplJ095BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NIaZ0BzM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NIaZ0BzM"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-503347e8715so56214301cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 16:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770768319; x=1771373119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weACp2fcT2pAD93VwGNy1+zYcxpwRLDotrd1TQInpE4=;
        b=NIaZ0BzMzLIqS33zBfFbuYppDd55qXUkO8Y7j7Ac9ihhAaNsdQruujZ9dhzOZI9YN2
         VGB6xydRbfYsex0NeQsFyISdNJwDcVONKFH9BT+kg7+aFEM06xSmOFOVEBi5AbFOp3/S
         lzzaDBRBA36TKP6HCt6Q2PCEa+ECZNtPFnLI2oBmKAq3T3wmhEFCeIiSjmummBYo1Gyt
         Gc00FCGVVm5sEgeiJQYzWKtcdepuRPQON41aV1HMVFiVfUMmRq3/e8FBVO0+uXLP/+9W
         EkMx5794G2jtyEZLjJSpGh15hhksfRwwP9hdzqBn+p9Lu7jomF+tg8kqFlXyT9rIetj+
         j9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770768319; x=1771373119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weACp2fcT2pAD93VwGNy1+zYcxpwRLDotrd1TQInpE4=;
        b=nDpZ2HVeQa8oo2E5LExLWfybAKqIiKJEpx++j404dAJzhR4c3LOG7jX7Igs0msPNYn
         PhUAdpZeQ7/oJvFwfe7/txAGmWQpKwthGIkOcx82kby8J7D70XaMkMP3NJHe/Rz0uDp1
         KlMPh9JAMum8fkqp9zKgH/guzTm+4CvUHSfoomtycGbQ9sZdB8EPvAoSrpqBTqbTzDaJ
         9ejZX7ooUkVKQc7RpYB2br0UEHANQI6sV0QeJdJ2ObEnieWJ3d65NwtiWf5wM4n7TTbV
         Ytnu3y7mUzubNEpMoGMJrGz2ld0ooL/S9XDffvXOESySJg2OvQGNrzdYsTo671RZteWp
         ze0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/xvxruS2R0qMqjfOUL8f6CzxbuVZ+oOzpLvqXbF+jIKUfARanF/cRs3lpRpthbVwEgt+CJ3gno0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hE4dOCk+fj0WC1JsUPpX+nJtTmMJTCybJ/mJJ5Htqrm6jbIq
	JO3tkDsPO478luiHG9uU9/c5uBy17tUl35a5bCcx7FgofXpfg3FnQJeuiTf/pbLteTZ9AaX/jJI
	XzTwO
X-Gm-Gg: AZuq6aKE/zMNqMVmEvB0hCgl+HV2Wn5mED1JTttrTI1foncnKokoCCQM92PnwmVR/4G
	hb8Z2bjCDObFuFi2mFpqcwDlZjKShVe64Vw3ggVGGQQClIJCmROX2pUg/s3A7Vnu1xyBv7skLM8
	5BdJ/skN/ieVQJ6Xsx2umK1+tAqhUO+dMB1zxvEo6xijlAwhgKELbhnYpOMU5B2us6YWstS9gaa
	MrfZKHttBqlhqR0D2W7jSmhvbRT/QcfsvIl5RIvVkdFTuWQGIXv+tKJN1Sokkb3py3ZxJJqejGK
	HUIfGKyOuZ2atDLNHiXnFpT+1r+ixNmPGhAC+4KgUXhnVbZBCyDaWbYHFz9lnPWWzHr0SdwHajo
	4QyQvN6vfvIJxT/Iq8mD+cNk3ML3C0nv2JY0vqy7UnQ9KTx3SYzGzsQsTuLuYAqD8nhHvF5vhmQ
	fMoiUFpXBY89CldmjKt0t/Y9fbJ+F/8gfA3kqCnWUGipMWAQv0LjRGp6Rd2aa39hg3CrPme/iNo
	L+/8Gv/w/WlWDbxQVGT
X-Received: by 2002:ac8:7d14:0:b0:502:f26f:1381 with SMTP id d75a77b69052e-506812391c3mr14841441cf.61.1770768319547;
        Tue, 10 Feb 2026 16:05:19 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdc18dcsm1460496d6.47.2026.02.10.16.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 16:05:19 -0800 (PST)
Date: Tue, 10 Feb 2026 19:05:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on
 attach failure
Message-ID: <aYvHvGfv6rJUVLJc@gourry-fedora-PF4VCD3F>
References: <20260210154320.1748223-1-gourry@gourry.net>
 <698b8a8620f2a_dce1110074@iweiny-mobl.notmuch>
 <aYu1M75-tV8-TLAC@gourry-fedora-PF4VCD3F>
 <c8623ed8-04ac-4921-adb0-14cf630a063e@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8623ed8-04ac-4921-adb0-14cf630a063e@intel.com>

On Tue, Feb 10, 2026 at 04:20:35PM -0700, Dave Jiang wrote:
> 
> 
> > I can either v2 or Dave if you want to just make the oneline change
> > before pull let me know
> 
> With Dan's comments, may as we spin v2. We have time until rc1 releases.
> 

will get it first thing tomorrow

~Gregory
