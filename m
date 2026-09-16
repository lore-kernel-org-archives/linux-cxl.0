Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBDB2DCF61;
	Wed, 16 Sep 2026 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562122; cv=pass; b=keTel0SiWYkBhkSeTsDW/bRRuoI4FXVLgndSPLDFuUsWnDO3ehtV5U20NRj6xgjUjSB1qnIv94zs6CafCwEwImLAQZMZr4foF0xudm66S2LLoJlmi9D2GTbD1V6ymY1sTSuowo3JUOmZcASnvaoJpIBnivcHzuiHBCFvBQjtSTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562122; c=relaxed/simple;
	bh=GNosz1XOEz92dw3lGZReKx/I0Sx1mwVmsK4kiaej6AQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SD8is1HFGQ0nSLyhhNgp4Da3ausXGeC8BZQMUVH/vcMy0s3FMUASVjZmTbxs7/2w7CxhkVsxwdHzA/WQzECuhCYpj36jOs1GL5x1zFDz4x01+Y/3pUIsgu7rhBigBypg5CuGM1kEQoKZbDctVuIkvDitBigTKQP71dWFHHVMEjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=QFwVKzj/; arc=pass smtp.client-ip=165.173.180.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="QFwVKzj/"
ARC-Seal: i=1; a=rsa-sha256; t=1789562106; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J7MRKSkjeQdYkPKWq730XX8O41xx9sgWeLu1xGVQgx64BKeQSF6QK4ijgZ8C2vaftag7SuF9TNKqxNzY3pVr4LAa8QFfGAoySuX1cFfqshvfUVG69vrxKNbbCQN5h9yCAiIqRk/BIiaaHSdpDWBeehg52Lq7vglp+zqgJ5LMppY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789562106; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gh/eXXjzN6tjNF8DxHBnR10bfGlOpZ51KTjh4kuJbbY=; 
	b=Zrd+UcUbIs+3mcpg9PBxNILRBtgPaFAqDVX3DUMAfJ0FW6ynvchs7eTZ7yWaHsfT3tTSiwdxURxv8HOGmW3sxCvjKh9dUOl3NGJl14hDL7nbpYF4c91i2kEK5IYTMzIa5uVb1rgsppQlF+xoqOtmQRIXAygHM+G6SXg7SnwG2J4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789562106;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Gh/eXXjzN6tjNF8DxHBnR10bfGlOpZ51KTjh4kuJbbY=;
	b=QFwVKzj/5G69/06wE/yyAIGbFz5kWpKFAEbNYyBHR5d5kZmQyc03Gqw2GV4mY9ft
	6eW6o7s4Ej1nxxAhuSgKpfaDYRlBUHK++7TTIrhTiKyMVnurvyRuu3EWzth+7uq8pho
	CPX4ICrnmH97G3WltRBxa4Dpefc++y9sJyWZWT5g=
Received: by smtp.zohomail.com with SMTPS id 1789562105403624.1132428261011;
	Wed, 16 Sep 2026 05:35:05 -0700 (PDT)
Message-ID: <58a6251f-b3e1-4616-b174-fab6548ee713@zohomail.com>
Date: Wed, 16 Sep 2026 20:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>
Cc: anisa.su887@gmail.com, benjamin.cheatham@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu0801122769fcaf78a8ca78b070c105d0000051c33f54028605a74cf22ca5cacddae8c371bf3649111d6e31:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/12/2026 5:38 PM, Shaikh Kamaluddin wrote:
> CXL event interrupts may share an MSI/MSI-X vector with other event
> logs or device features. Consequently, cxl_event_thread() is registered
> with IRQF_SHARED and must determine whether the event-log facility
> claimed the interrupt.
>
> The handler masks the Device Event Status register to the event logs
> supported by the driver. However, when no supported status bit is set,
> it exits the processing loop and still returns IRQ_HANDLED. This
> incorrectly reports that the interrupt was claimed and prevents the
> generic spurious-interrupt detector from accounting it as unhandled.
>
> Track whether the CXL event handler claimed the interrupt and return
> IRQ_NONE when no supported event is detected. If no handler sharing the
> vector claims a sustained interrupt storm, the generic spurious-
> interrupt detector can eventually identify and disable the affected
> IRQ.
>
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
> Changes in V2:
> - Emphasize that returning IRQ_NONE enables generic spurious-interrupt
>   detection and drop the Fixes tag. (Jonathan Cameron)
> - Check whether the event interrupt is already disabled by Anisa Su's
>   patch; no code changes were needed. (Ben Cheatham)
> - Rebase onto v7.3-rc2; no code changes.
>
>  drivers/cxl/pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51d..8b560cae91f2 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  	struct cxl_dev_id *dev_id = id;
>  	struct cxl_dev_state *cxlds = dev_id->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	bool handled = false;
>  	u32 status;
>  
>  	do {
> @@ -527,11 +528,13 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  		status &= CXLDEV_EVENT_STATUS_ALL;
>  		if (!status)
>  			break;
> +
> +		handled = true;
>  		cxl_mem_get_event_records(mds, status);
>  		cond_resched();
>  	} while (status);
>  
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>
> base-commit: df2908090cda368b01ff43709f51890076c56157


