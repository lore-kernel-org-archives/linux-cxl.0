Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4144CF3C
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878753; cv=none; b=rIDs7qhFsMIND9DLWAs1a9wpMQq3CZseL/qZANcJIstHl3NfvBvYhFs//ucIC0G2UgIysG4Ze7KsvDRWBm94guevNUSlhW70jsvlnw0ke/+59MYAlb25y4np8vEiPaBwcQBc+taOa91Kw5EyRGwOH+PP1wqb0KPe58ZVALupGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878753; c=relaxed/simple;
	bh=jwFf19PSHKXwdf9bEk3kZxmxUld0e6v3BgfnWrHCUjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaLQCx+Z9x2lSOIAn4AnQ1YOiID1SYEsBjH2D2a3E/kJnVPS4ZqVdcXKjGXAYUsVhxWxhlpJTIGjMXN4SVofAcZMxRieLNzfv1Ngw7juAJTWVQEZIG7OczncGUpYrhG81UnMaXV8ZRlpxMGZQBUILygt5TQ13PwZHPO8p7JpNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+ubIeNp; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+ubIeNp"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7cdae63171aso2224866a34.1
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 05:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767878750; x=1768483550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E49XAlEZRJNJzFNz0O0SAsxb11w6Gi0a4fcPebK/tXg=;
        b=R+ubIeNp/lncYOXBpbXdxWxD4pwGcq7tkrjrm1VRvjztIpk4hRG7WV1/EeON0ROBdI
         Aw4wvKH5g3ucA2mj6Vh8dqZRuuR/3h5QHNPC+LxkKDTECCrd11Mx3/pmm9zFu+wYCVM9
         2R40p5+/1Hd4aXVSYDstYBJfQyoqqPGWsXywvSGcHRhC8Yx8AJHMIZb9WF3wT/kE2Zpu
         A7xaKpemg5BFufEBSdCpwjdYQywy/oFM4y1wUDj3kScVn//AxI9ukSHVd/hAmMF6OHbS
         tZNrVTzkF7U/66ARQOi7Brv0iQafnFZAWUvsZ3l3x9Idt9K7l/tJ//kXf9xlDwIRmPGY
         xwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767878750; x=1768483550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E49XAlEZRJNJzFNz0O0SAsxb11w6Gi0a4fcPebK/tXg=;
        b=NrxOPBJ9JzpJqqKrTBtw2pX95ydXvZsMKriBkwbX1lYzznf7swPdpCeHkgwDVV6rFY
         9HRk8LDJgEjXoj9PkgwV8Q8qserDxEfQ29XJyYUi4LAakKloLBHV7+6Dac8s9eY7R91+
         k13vaGyH7yKkcIZFEXLddv6ZPeiHIS07rfwCtGsst/dAn8FdA9uGs/Xe5W/dDr2b3FU8
         EpIw78zeVGU4aJaK/yt8owCA1Y2V4TWOaeC9jgEyPf2wpIxoaT9z3TOQ87mdro0/wNlU
         UmNx+ooNx0d1geJ948fYqMtSEDRH6QvgY4B7SLMVU/3oG55+TSewisVCxuyjqY62ZFda
         e8zw==
X-Forwarded-Encrypted: i=1; AJvYcCXevT3vKvShUQunIaCyWSd5Lve1/RQ1baG32JxVRqGuu0E0qjRA9GOTyMLTCFhVRluzFeqwI4gKjfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6W25VyNkqQZiEEiNzeZJSjlfAfSBMiqa926igjCY8ANcQYgE
	itEItZPOhscL5vWDSwiLwGNCMfDUh6yrykjXB0kJ28YP7kvtMpCzaZrN
X-Gm-Gg: AY/fxX6R8T3opqJ/uu3V9LCowNkwrShQ/Qcsy/MuqmzW4oXHLU1Ft1dWTxunNY9mj4P
	MN74qTxFbzVYRfVmBipB8nm32GyR9VK9iQIpHt8PEZabT2D8Yw6D6NQqzpfnZWG8z9E2jApgXzX
	ATAARGxtdGwIjt9zVCnexi/YKwZhujT55fRV9z3bTa4K2wRD8IyZbX5wDDzsbhnP593ZC9GkNQn
	gyt9BUoCyOSHDlnxxxgXk11DPIOXkVwOkeTKUuObzy1jAJI53Pvjnk20wAna82BmChGRlOC90b4
	iTTVKWbF1B6RrgE17JBGwsk9T/832AtIk8TOp/NweXiHdQlFwuSyicKhfUhI0tZ76qdEOUz3yKr
	TW5pqiduvrk6Eqju0eU3b2CW8JmYZ4OZvtzRtIR6GjBs0HVXY+P6sER5p2FF9YWTurlrNhrpxAP
	6HFE8m8B+/8++O1El8wl/ACzHzCEEuNw==
X-Google-Smtp-Source: AGHT+IHiefcf7btCQSFUKrAxCiXJ1hW45Y0S4Hc66MlrtJ5LVsP42OyHRUDsrUHUXG45rEL7nC8tMw==
X-Received: by 2002:a05:6830:411f:b0:7c7:6850:81a2 with SMTP id 46e09a7af769-7ce50b57c2cmr3718104a34.24.1767878750143;
        Thu, 08 Jan 2026 05:25:50 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:902b:954a:a912:b0f5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47801d63sm5317503a34.6.2026.01.08.05.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:25:49 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 8 Jan 2026 07:25:47 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 01/21] dax: move dax_pgoff_to_phys from [drivers/dax/]
 device.c to bus.c
Message-ID: <3kylgjwvrdrfe5hcgqka2x2jsgicnnjssdpjrqe32p6cdbw33x@vpm5gpcb5utm>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-2-john@groves.net>
 <20260108104352.000079c3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108104352.000079c3@huawei.com>

On 26/01/08 10:43AM, Jonathan Cameron wrote:
> On Wed,  7 Jan 2026 09:33:10 -0600
> John Groves <John@Groves.net> wrote:
> 
> > This function will be used by both device.c and fsdev.c, but both are
> > loadable modules. Moving to bus.c puts it in core and makes it available
> > to both.
> > 
> > No code changes - just relocated.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> Hi John,
> 
> I don't know the code well enough to offer an opinion on whether this
> move causes any issues or if this is the best location, so review is superficial
> stuff only.
> 
> Jonathan
> 
> > ---
> >  drivers/dax/bus.c    | 27 +++++++++++++++++++++++++++
> >  drivers/dax/device.c | 23 -----------------------
> >  2 files changed, 27 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index fde29e0ad68b..a2f9a3cc30a5 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -7,6 +7,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/dax.h>
> >  #include <linux/io.h>
> > +#include <linux/backing-dev.h>
> 
> I'm not immediately spotting why this one.  Maybe should be in a different
> patch?
> 
> > +#include <linux/range.h>
> > +#include <linux/uio.h>
> 
> Why this one?

Good eye, thanks. These must have leaked from some of the many dead ends
that I tried before coming up with this approach.

I've dropped all new includes and it still builds :D

> 
> Style wise, dax seems to use reverse xmas tree for includes, so
> this should keep to that.
> 
> >  #include "dax-private.h"
> >  #include "bus.h"
> >  
> > @@ -1417,6 +1420,30 @@ static const struct device_type dev_dax_type = {
> >  	.groups = dax_attribute_groups,
> >  };
> >  
> > +/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c  */
> Bonus space before that */
> Curiously that wasn't there in the original.

Removed.

[ ... ]

Thanks,
John
