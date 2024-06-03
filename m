Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F80139D04
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444186; cv=none; b=kRlKWgzUrI5ikfwzGWNlHNYAdJoiTV30CwykdjTgIKyHDw7EqnwSCCctZWUFZv3pOJGe61/gLVMu7owOlifOhXDXq0kt+8e16Y1KmopFnjh2JNH0lVinKTJo3wJT0JKJd5U0UXYgO5QZ4+8ELle2h9VsrYbVuxiWrp8slZTrqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444186; c=relaxed/simple;
	bh=WEuqUnPNAb1DI3EqIJBqZFbfACrCPb2rQr3u0PBTUnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJZ5Bz0ICzCc23VqbsvUigfA5nt8uCoUC1uUR5B+/vJbgTJBAQlz8De3noLg4O/TNBYyXgcgX2hiddMLCOmEpFF6SOIuQkZIe9mhj/Gs+Q20+xe9PPe4LRaEVKfum/14Bx/TkFXJNswICs+j3ywHnwZh70LyTmblruaYAh4WhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dBBBWUn6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dBBBWUn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717444183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXGaVSP1cFFNV4dEuxpxTKr8wpTXGnmFrUnlz6ILBlQ=;
	b=dBBBWUn6nk2iJyUakJZTXZSwyN5+sg5wu5m8S62Zffx0T8Ezfoi7QwjAbFeJrn3l8KGJpw
	avDmzklY5bOgu08KEmowX8GT5sASa9lLvWOE714v5MRT1ZlRE9Kx3+pw03YFmAYlIGRHO9
	CJIjr/EES8EDotyulq0E5dT/qgOj41c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-bKmZO4fJNUC_qLDmTCWgcg-1; Mon, 03 Jun 2024 15:49:42 -0400
X-MC-Unique: bKmZO4fJNUC_qLDmTCWgcg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2eaa38c4313so18806741fa.2
        for <linux-cxl@vger.kernel.org>; Mon, 03 Jun 2024 12:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717444180; x=1718048980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXGaVSP1cFFNV4dEuxpxTKr8wpTXGnmFrUnlz6ILBlQ=;
        b=Bkh44XD+S4I0aF3M1JZyqUwxcNzHH9ftTA5Nxd0tgPyfyjUgtQ0GPIEfqUMKjDlo0X
         g2Bz8VQFND1shWHdImvpznUVzdbxX/p+ahkjUlIzdQk/zvl0P8uqS6YBdRgHF+GWlByg
         nh4MTmtJqJvbb4QOTFPUm6SQYWTpRA+PcaZjT0KiblXrgoOb440z2GZx+rQEWprROBdp
         6CYh8EJFjOEcmJPBVXAQMc0qh8BMsSoTI/CdWDvC6CDWMMX27w0LvybVPJ77l2JMGiJh
         iQy921s6HrtAjbMLM1kHsQCV+XTo1ftMtH+s64guSO5nGakUEVSk2waNmR9NJw0M7R0l
         2iEw==
X-Forwarded-Encrypted: i=1; AJvYcCVqWZ1PmkkgOhz3Fd7b0mrAfibPEnd2qM3qzdI8TJzLSefLq7fL10A1Z46LaEg7QV3Q+QcxkdEu9AYZNjkHj/5+j66rr4R6CK3q
X-Gm-Message-State: AOJu0YxcUk0DK2e5t2u+ulJPHGzzTtABxCFRjHNwYeVtHhubvhFe72LP
	bOqPtQJszBfwRlKZTsmCUF9dELaZ2iVlBc7IIb7eWcoCAIUincbZhYDPm9pRsQ+86OhQyN1mKAP
	kH+JZuPq7iGPk1yfjtpezf9skoALA78+5z37J7L+aOia0RvLJw22DS5FI02wlhiO+GQfq
X-Received: by 2002:a2e:3202:0:b0:2e9:855b:7014 with SMTP id 38308e7fff4ca-2ea951d4f58mr62232271fa.44.1717444180538;
        Mon, 03 Jun 2024 12:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEicqFjiXcHgBKsP0jWUx0Z+oQW/Wff9OVSRmKJxZo67GkVZu0wQOBVc6oYllXdv3vKAq4B5A==
X-Received: by 2002:a2e:3202:0:b0:2e9:855b:7014 with SMTP id 38308e7fff4ca-2ea951d4f58mr62232191fa.44.1717444180125;
        Mon, 03 Jun 2024 12:49:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31c9c0c4sm5970261a12.83.2024.06.03.12.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 12:49:39 -0700 (PDT)
Message-ID: <6daf3a21-6e78-4a82-b03f-af9462fad012@redhat.com>
Date: Mon, 3 Jun 2024 21:49:39 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
To: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com
Cc: Dave Jiang <dave.jiang@intel.com>, Imre Deak <imre.deak@intel.com>,
 Jani Saarinen <jani.saarinen@intel.com>, linux-pci@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/31/24 3:04 AM, Dan Williams wrote:
> Changes since v1 [1]:
> - split out the new warning into its own patch (Bjorn)
> - include the provisional fix to the pci_reset_bus() path
> 
> [1]: http://lore.kernel.org/r/171709637423.1568751.11773767969980847536.stgit@dwillia2-xfh.jf.intel.com
> 
> Hi Bjorn,
> 
> Here is the targeted revert of the cfg_access_lock lockdep
> infrastructure, but with the new proposed warning for catching "unlocked
> pci_bridge_secondary_bus_reset()" events broken out into its own change.
> I also included the proposed fix for at least one known case where
> pci_bridge_secondary_bus_reset() is being called without
> cfg_access_lock.
> 
> Given there may be more cases to unwind, and the fact that I am not
> convinced patch3 will be problem free I would, as you suggested,
> consider patch2 and patch3 v6.11 material. Patch1 is urgent for v6.10-rc
> to put out these lockdep false positive reports.

I can confirm that this series fixes the lockdep errors which
I was seeing:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
> 
> Dan Williams (3):
>       PCI: Revert the cfg_access_lock lockdep mechanism
>       PCI: Warn on missing cfg_access_lock during secondary bus reset
>       PCI: Add missing bridge lock to pci_bus_lock()
> 
> 
>  drivers/pci/access.c    |    4 ----
>  drivers/pci/pci.c       |    8 +++++++-
>  drivers/pci/probe.c     |    3 ---
>  include/linux/lockdep.h |    5 -----
>  include/linux/pci.h     |    2 --
>  5 files changed, 7 insertions(+), 15 deletions(-)
> 
> base-commit: 56fb6f92854f29dcb6c3dc3ba92eeda1b615e88c
> 

