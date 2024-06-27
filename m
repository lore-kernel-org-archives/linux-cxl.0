Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA9B1581E1
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492363; cv=none; b=MkywaPd5fBc1EDU/G+2tS4d1bm4bmXHszBhe48ItxnbaN158+EdSwBkIHWoSoLznhk/NXADsrS5Hve6rm230v4SrH2PWUHCrtfY//EpCcyl3OR8ku3RqUnke/Oq6mefuzBjrsrQQ52oa2RVg+ut0FWEYPWvNYP/DkRGWyEanbqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492363; c=relaxed/simple;
	bh=/qifVa4h6wS+jWCrLsFLFaXQ6+Y+gZxTpCO+yWP6G/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsXrcAk/OeG34REVa6RkLesq/4wGSL/vmBRw8zPj+fBCI6nhuDTDXUEImIiYQ+WzbQ0MaBu7XhLIvupzjP4fYPce7l+U7R79BSBvaBjSXk1yWMywAlZa3wva/6KivOaceG+rBEY3dZ4/UrNC1VssqXc9dLqVPDccgrAD7dhwwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dD0kmReF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dD0kmReF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719492361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEyXyjrz0uT0L56DM07tTAES+eOWE4OCv7rGSKUOWNM=;
	b=dD0kmReF62kfq0sEMlsRulWSSr3RU7StWwZlYb4AUjeCfGrrF9aXYC/ekjDe0kiAgYerIa
	ARRIhNOY353Drv/HTSDEx+XVoHmZ7ERhFkY5ugpWJrS7bSXfm2QNXj6hGO563o1fvAzWd5
	rAFs9/BonOmb1Cs6zFqfqrZNAI6njnA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-Wxf96ZchMAOdRBi6ryZ48A-1; Thu, 27 Jun 2024 08:46:00 -0400
X-MC-Unique: Wxf96ZchMAOdRBi6ryZ48A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36740a84ad8so699326f8f.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 05:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492359; x=1720097159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEyXyjrz0uT0L56DM07tTAES+eOWE4OCv7rGSKUOWNM=;
        b=jvo4AmBQ5wydvk6Qcv0RJwN0L9ZwXxk1hKE6zZnb5/hzQQ2SgcooIYtzKzTRLzs7W8
         rR9NYDU0639sdslZaTg2gqOopsap9EQfr8bnu6732Aay9lvTftzJ76nSxk8f0OcubNKn
         HQtmV3pWJmy6bZ74cWnIk6kXEmr5Ubz3jMx5OY2ROs4QDrRGG/N1ak5XD8qe8OAC4Tjc
         TZSPp1yQGvqEuvSKr8GbyVtF8gbCkxUxkabCAdQCmrX0Rx9qGHmtYv7xacs6ZIqMO2SN
         8KfP7y/abANk0S+ci3RZqFaTjA2MneAiUazwrXtGAQF9dFdOqtIuf56+sH0i0io6opMN
         CPAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw44fSj2dAhCYfS3d0f6DTNz1Q41oasixb7uO+d2UD7RYkguU9Eo7BZeVK9CwdZKCsP7u6yS9evLpZehws976pX+BhPeCM0dDY
X-Gm-Message-State: AOJu0YwOOBOL0obPjnHRyZfIbQP9O/L2Bxmlewx64LjVEvLKFArmrx7y
	A/ojJ8z5CzSc0ZBaRCrLzwby3qHEzykACDjeCKPnbtUcKSDcsUp6OQduZ9Y8F+GxyEHvxtVoEWp
	PyyrlUxtS+YPrnpUxvWUmApuSfFoFDYxfwOaOqZcDHu0MvQ+Q5wH3VOv1Xg==
X-Received: by 2002:adf:f1c8:0:b0:367:42c1:516 with SMTP id ffacd0b85a97d-36742c10599mr1706658f8f.18.1719492358877;
        Thu, 27 Jun 2024 05:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYnJOYQggJiXKXxSMzsFo4hr4SuN8taJsLKh778dY6XPRmMVE7b1+mR57fG/XpIGlW9KYXiA==
X-Received: by 2002:adf:f1c8:0:b0:367:42c1:516 with SMTP id ffacd0b85a97d-36742c10599mr1706633f8f.18.1719492358497;
        Thu, 27 Jun 2024 05:45:58 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674369ec7asm1741891f8f.112.2024.06.27.05.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 05:45:58 -0700 (PDT)
Date: Thu, 27 Jun 2024 14:45:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Markus Armbruster
 <armbru@redhat.com>, qemu-devel@nongnu.org, ankita@nvidia.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, Richard Henderson
 <richard.henderson@linaro.org>, linuxarm@huawei.com, Dave Jiang
 <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, eduardo@habkost.net, linux-cxl@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 03/11] hw/acpi: Move AML building code for Generic
 Initiators to aml_build.c
Message-ID: <20240627144557.237e3ab7@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240627084356-mutt-send-email-mst@kernel.org>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
	<20240620160324.109058-4-Jonathan.Cameron@huawei.com>
	<20240627144244.27473a32@imammedo.users.ipa.redhat.com>
	<20240627084356-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 08:44:14 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jun 27, 2024 at 02:42:44PM +0200, Igor Mammedov wrote:
> > On Thu, 20 Jun 2024 17:03:11 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > Rather than attempting to create a generic function with mess of the two
> > > different device handle types, use a PCI handle specific variant.  If the
> > > ACPI handle form is needed then that can be introduced alongside this
> > > with little duplicated code.
> > > 
> > > Drop the PCIDeviceHandle in favor of just passing the bus, devfn
> > > and segment directly.  devfn kept as a single byte because ARI means
> > > that in cases this is just an 8 bit function number.
> > > 
> > > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > > Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > with typo fixed  
> 
> typo being "in cases"?
> 
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >   
> 

nope, I highlighted it the patch
  > +void build_srat_pci_generic_initiator(GArray * table_date, int node,  
  s/table_date/table_data/

