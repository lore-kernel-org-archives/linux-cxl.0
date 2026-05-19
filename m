Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438D627281E
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208044; cv=pass; b=I13PX8XHuBDC0ZJZqtcaemdrcMCgXL9eqKpZTbELY5OjTGaB5VEdTbymupbmBzUr0Pv5EK7WUoIA9OmMAFjRxXUzc7dphAmoRwdud/FbafLaxIz0QkU6Fu/ccA0CjWBwsPaIOrrZS1AF5x/Oh/M5V8RS7TgzSf0l3QrMo3J7Zwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208044; c=relaxed/simple;
	bh=B6BJ3Zsa1dczVVp0M9UD9HVDpJCBAvt2NLaHwYhQoew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq2wTR/b2c4zGUDP4tOzOe2mOFd91Kq4DQGl4xLKR2csgL6wMyOBn9Fda5z31UhmR0KhbYBYc3a3LUkES44PHfK9Iu0C2UOvsV7N3lQJCpRjA11VGcd15ZDsYYRLuREnCOUxbgBXQA/A9JdPY7FEfWj12B2T50+QAf17qKlrEgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOJL2ScV; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOJL2ScV"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso8880993a12.3
        for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 09:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779208042; cv=none;
        d=google.com; s=arc-20240605;
        b=ig+7lrTtCK3vHALOhzmFG4aAjSzphJDdomd2lrV9ywEfw+GzPdJ8KBhjXbuKWOahJK
         GJon53++f4D8N3cNb8CPFat3zwXeUX+W6X36TDuqIn1aN0Bnr0PBAXX+JIAzOBVQfGBD
         xWlVJW2N1GgeY2OIMvFIz4Igi6uJLdBgxTMhVfy4CkH9GA40nxDwUA/LgGaxKAOZ1Uzr
         kT7KqHYnX31/v8mEafwvisLBu+wPD41gZjjuTgX7JaFuqVG9E/47g6c7XCycXymSGnsH
         /iNnH4CcObxCIqQwplTN3KpFWj8S9rTDbZpfJAgLC0nOwuosVHGyXZrqsDFsTS9va10u
         1EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5usbpjdW6V4GRZxIENdpTSPGB2A/F8Hn+HvhpsraCUY=;
        fh=yqYkMf/WjiJCCJSKKIwyHb2Sp4WylU5M+1qfemQ2yyU=;
        b=VoTV93cpPjyAazy9OzxQGT8tI9w9KdeogzVR1QAU5Vo6o08vfSDAQLTi9qI+N8XetL
         pMDnwvyBFt6vhAWeW9lqpUGDpGuuvQa7qVPJSUpw/0tYBqEcjqssA5E1kvs44YEfsdE7
         4bJ4NQDlcTj3RCX61ZMXDbl59vAWXvqyR2hn3R6QLR9Nqgi0fZxVLjZHxFJVfSpV5JUb
         8j9qnJrxPR6FxxxC7WIshVK8thgSO8XzRggTqMb5tAt1iu2N8OrsiwuiKvKyKiWm2+Ld
         Cxye6/trFGcRoUMYMRGg8wNjfXZ31MXGDJy/aV+YJAJy4m2WvMYvarfnRtXOmVL2tZZQ
         +znA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779208042; x=1779812842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5usbpjdW6V4GRZxIENdpTSPGB2A/F8Hn+HvhpsraCUY=;
        b=AOJL2ScV0gHxhzWMeYgnozojKksV50S1PyHfAe/SxObvSctFfnHXVg8CUtIYaQIjkJ
         UYoxR1Cc1HkdTH017gSzgDk/Q3vi/IF1JyAO8VQ2S2iCiFZIDISVzjhA8qFGOeQI+ZyQ
         VN0gWXhJQ9XewAy1hq0dzeuh38Pho5sLIsMxdnMgiry6+8+PtGABzkOwEimxQv+Anl81
         WEaOqwvpBFdE/StwUKuesxG5tfcICuoYMlHULWFbgbhffOxillFKB5su4gH/5Izr7cLr
         NbESmd31uNVV/4hxMNvFFBbWYldaeFIc8GHEocRTp14kN1nvaPARPYLC9TuDey3HnuCF
         mmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779208042; x=1779812842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5usbpjdW6V4GRZxIENdpTSPGB2A/F8Hn+HvhpsraCUY=;
        b=L/d5t8WCzs34FYivxfd9pUgu3zdvMZsCFEQKw6jBVE+9HRjuvT4ekbE2+zb7+O2kaV
         OShh3EGHk2szaQpqgvpNuUvUTOEgPU0/UphtS2/obcHeEw3kdkJ8dKPTQmKzmRFkqduQ
         24DGzm8qi5Edx9u3xlbicavb3vBi3Jy4Khb6sczGBoRV/zbPQHb/iv2FvysYqWibc+3d
         a4DM9mZ9jHb1eZqIEDg2hJxbSTBq6MtP1z0XWkXC/zo0q8Y5opQhLVCKtDEUlfNIx3ZZ
         wnFy1O1Ba/8sXoXfOPzC+IMhTWUl2KI0LDh6fW5TMYcbEdzLTqyINiAAD7Ah5CG8AThy
         LnQw==
X-Forwarded-Encrypted: i=1; AFNElJ9afBXTTAgoQecCUIXoSSmdFlFCLW9I9P3Wuc4cItMSpUcsfwdxsP8Xw6BL4JGOuV4DR5CYtXl5+rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Kz0AHsyjNv81ybmULbXAU+C6znFqsVoq5lKgL6ol9zY2xdE/
	8jbKrmIHjZVjRxoYMWNBS1RNNc/JXI9oBezXsw6nQeXvawR6yVvirUT+XywJjJhXjXPUDQ6eDTi
	XDVPQ7Xo+ZklpfCvt1nRUu0Ggy8t2N7w=
X-Gm-Gg: Acq92OHsr7KzknNdRkgYhCXOxehnRivEfxOZxqZakwAmgY3nFgJcC9eCF7bNYgcKS+e
	ssq3aU1oURbjdvr2RWqUVbZlYbH2T8oJYAo465gXXxZuM9A7J8igEF0RA8fSvwoKbqKUWXBgB3j
	t44RHWHY3CQ2ox3/yIrYk4+jfU3iFGGvWGtEohmtiJ2ArLAIdJBzA8d5xo+5SadSqryjjMC1tdO
	H8JTyMACRiOzWcrdZnuH5o/Z3zDbdaywISNv0qrIS2ak7FCQYi+zTxeWVaM832oTkzOgg0R7Sdi
	eckSsnabP29CIeiUCUiyohn1ergVqhLPvanfERzG
X-Received: by 2002:a17:907:9719:b0:bd5:2a43:b471 with SMTP id
 a640c23a62f3a-bd52a43b4bfmr929160266b.48.1779208041621; Tue, 19 May 2026
 09:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519151008.1399226-1-qkrwngud825@gmail.com> <5d00b63c-1802-450f-8e54-8da6c0aeedc2@intel.com>
In-Reply-To: <5d00b63c-1802-450f-8e54-8da6c0aeedc2@intel.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 20 May 2026 01:27:10 +0900
X-Gm-Features: AVHnY4LdRR3qD6dMJRp9P0dqGJ2iwd73wpIsKyKrAimUaQe9thTXgPYirbbLgfM
Message-ID: <CAD14+f2p7D6eco+-O0X6zWwi-XaxGLs0nQKDAC8eVWhQmB1VhA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dan Williams <djbw@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, 
	nvdimm@lists.linux.dev, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Wed, May 20, 2026 at 1:02=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/19/26 08:10, Juhyung Park wrote:
> >  #endif
> >       } else {
> > -             pagetable_free(page_ptdesc(page));
> > +             /*
> > +              * Use __free_pages() to honor @order: vmemmap PMD leaves
> > +              * freed here are not compound pages, so pagetable_free()
> > +              * would lose leak 511 of 512 pages per 2 MB chunk.
> > +              */
> > +             __free_pages(page, order);
> >       }
> >  }
>
> I find myself really wondering how much of this came from a human and
> how much from the LLM. Could you share that with us?

Not my first kernel contribution, just so you know. (first in mm tho)

I asked Claude to write both the commit body and comment and it was
too verbose. I manually trimmed it down.
Sorry if it still sounds too LLM-ish.

This was tested on a VM with virtualized CXL device and toggling it
back and forth was visibly causing leaks. kmemleak was unable to catch
this (rightfully so), so I skeptically asked Claude to see if it can
figure it out while pwd was the kernel source the VM was running.
"Access the VM at "ssh -p2223 root@192.168.0.185". There's a memory
leak whenever CXL memory switches modes via: daxctl reconfigure-device
--mode=3Dsystem-ram dax0.0 --force, daxctl reconfigure-device
--mode=3Ddevdax dax0.0 --force. Figure out why. If you need to reboot
the VM, do not do it yourself and ask me."

It did in 6 minutes and it basically told me to revert bf9e4e30f353. I
was very skeptical and reviewed manually (with my short knowledge of
mm) why this would be a correct fix.

>
> We're trying to get _away_ from using the 'struct page' APIs on page
> tables. This goes backwards. Worst case, do:
>
>         /* vmemmap PMD leaves are not compound pages */
>         for (i =3D 0; i < 1<<order; i++)
>                 pagetable_free(page_ptdesc(&page[i]));
>
> Right?

Shouldn't I worry about the loop overhead? With order =3D=3D 9, that's 512
iterations. That's compounded to O(N) when the entire memory size is
in consideration.

>
> Even better would be to *make* these compound pages.
>
> Even better than that would be to use some 'struct ptdesc' space to
> explicitly store the order, just like compound pages. But that's
> probably not trivial and probably not great for a bug fix.
