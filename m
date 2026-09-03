Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C404A013E;
	Thu,  3 Sep 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452829; cv=none; b=orhgky7RAFqjyPqTH0czL0XNezHnE1/n1HzATed3wHWr/orLJIzXO07vXJTGudYmpa/4uG2PsrKFVTGtF9ArSMaUnA7ayutcdPEY9mbc9rNbjfT9xfirlxLk3gYOYaud5fjXy6EWD6Koca37VTDd3k4Xc0jrMeA8+d1OWu6rCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452829; c=relaxed/simple;
	bh=Xmn1/z6estkZAjXAzQEq8DfXvomwyrMO9NoNGGW8ugg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMbXb4EJkgnAZ/Mj1cscAI/iDcTbgTTazZKlOI1iC+7FYvXQolNeMQfbRqudAYL18XHO1HXjljkogba6zxUrn7/1HruhB7KOK2F5swWNTfnRMVQlLhCPNEgjs0wK+pR+TojWsO7oqgUmw/TQ5GxAr9mmeO0Csw3QkABYTW7qBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bWCxmN4M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bWCxmN4M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Dws1cx8yCjIvHLxZf50wsdIqDs/2Cdbb8dzyT+t4Vmo=; b=bWCxmN4MvuHoq9Cmwdp3sJp3h3
	H9hia10uxU7rDvXhRMJfLRllZfAuotArBOp9Ot/kZoW/GvX/0cRqOX782f3QKLBKkXus+4jHzfq6x
	lYdoI6xqDEZ2X/D6PJs9E3kpmkPF/ZL0gGdzbKr8n2gdn8Nc2GXHfNsLlpLyuZEP5c/9mJc70UZk5
	QVWN/f540M0AN4+B7WrpixO7W+gEcr/FeSG72jkFVljmc7hZvRjEoK8vEjebxfXuMQluwMHtT3R54
	J8kgxHpo+vfhbG/Lnd547H5KR+12qp7mZrvVEtpyNuYE4k89Ph5XxTsRgpYcrqCRb8qHm2QDAWZDu
	wRZDORiQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2AHE-00000000AFX-0xk3;
	Thu, 03 Sep 2026 16:27:00 +0000
Message-ID: <249b535e-e1d7-4735-9bac-d302bc773cab@infradead.org>
Date: Thu, 3 Sep 2026 09:26:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: docs/platform/acpi: Fix brackets
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903095445.729419-2-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260903095445.729419-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/3/26 2:54 AM, Manuel Ebner wrote:
> Add '}' and fix indentation.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/driver-api/cxl/platform/acpi/dsdt.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> index b4583b01d..73b23d82a 100644
> --- a/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> +++ b/Documentation/driver-api/cxl/platform/acpi/dsdt.rst
> @@ -25,4 +25,5 @@ Example Compute Express Link Host Bridge ::
>              ...
>              Name (_UID, 0x05)  // _UID: Unique ID
>              ...
> -      }
> +        }
> +    }

-- 
~Randy
