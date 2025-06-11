Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959782E610F;
	Wed, 11 Jun 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749641306; cv=pass; b=rj9alpJsUv7+ZXHslHMtHDaJKngsJb4G2jY1UXsNl1Uc6Yu87RbBMrL/4b/m+LKmEvvh6nCag+NX8TJ6ayt+iCZ/nYI979JzEITtOU/vahdhIiZ572WNB+kVmSu1IGsz1Yj4Kg/bJqXlT1BeGQ31sXB0RwqRRQUijcRX95Bzev4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749641306; c=relaxed/simple;
	bh=9bAtrOVhW58iEopEem9hle2TkK2vl0U06nsZRHdY2WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcfxChmgBxEicXL1YKiqRSUH0pw0rycVNMloOhHRJNFY5PAkOmjdtagnUleje9JbI8PE2/ArPdbSpS+zpHI8viZUJgNcE5pjOLcboys8Q02o1n4qh2GdvMpXHnoNv/wQ28CmjjqDi0TZb1Qwyw74SOUcVaq2NrTHxvPcjLqGSoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=EL0+sO3N; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="EL0+sO3N"
ARC-Seal: i=1; a=rsa-sha256; t=1749641287; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fsiu+Xri1nDZzPMh2VCN8zq16LVAvMTjJ3OmnQAfIo0Cd+KL4q9SxcK3920bJGz7iOp8KBthE5wbX3MyJsuQ5UXndftvs7ap/zPmJeRRcu+AywXgV56qTx/Zh0pgBceNkTBmguW5etg/i2uo23eJ91vDuzufTKqMF+HQm/Tlnb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749641287; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eEkRwX3bcu6d9EfxMC5QWhVU9QbG0O36o+5JpYQjZko=; 
	b=BrcOXrJ2C7LB7B2faYy7CD0EMtHlee++Mjvp3Qla8lTPgXOrp3TtJMA4595hKNtsFzizTlzF2+hvATCzSnorm7BoOd47ANqeTs/TiRgqVIsqcSfDHQcUXwyFXsMl3TH0r+1ZOkyqiwFiGsy75WqjtQKtPO5q9KXFq/+abRj4e/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749641287;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=eEkRwX3bcu6d9EfxMC5QWhVU9QbG0O36o+5JpYQjZko=;
	b=EL0+sO3NTKluuiu0tfMLuruliVOsc6MS3mmXKzhwxa+VNLW2L/CdR44yzfxEv1hL
	/iiycqgnXjYcs6wZCppEtEpw8XfErG/dxDZ1HIWljWlRk2FO+hBOnXnwwAxuN9eNNKC
	nCryFPo3CcQYXq05rnv0A+gNk2O4EMvIbtyESIGY=
Received: by mx.zohomail.com with SMTPS id 1749641284765481.1752739316735;
	Wed, 11 Jun 2025 04:28:04 -0700 (PDT)
Message-ID: <a0205f77-e9b4-43b0-89b4-92897202c6f4@zohomail.com>
Date: Wed, 11 Jun 2025 19:28:00 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: fix typo in CXL driver documentation
To: Nai-Chen Cheng <bleach1827@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Shuah Khan
 <skhan@linuxfoundation.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>
References: <20250610173152.33566-1-bleach1827@gmail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250610173152.33566-1-bleach1827@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122758dac63f59411b822277c55400007f0e272b1e9d9f9c508b30d72fed609010fdc86e6cbecdf7e7:zu08011227c9d23f366ad105d643218e08000082d2ad27e97dfe0b0003f2bde8789392502be4494b363dda8c:rf0801122dbf444edff5dd7069e0cf5aa000007bb2898c1b75feea3ca715bc354293820032d6e470cd1008144da1145df99b:ZohoMail
X-ZohoMailClient: External

On 6/11/2025 1:31 AM, Nai-Chen Cheng wrote:
> Fix typo 'enumates' to 'enumerate' in CXL driver operation
> documentation to improve readability.
>
> Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  Documentation/driver-api/cxl/linux/cxl-driver.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> index 9759e90c3cf1..dd6dd17dc536 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -20,7 +20,7 @@ The CXL driver is split into a number of drivers.
>  * cxl_port  - initializes root and provides port enumeration interface.
>  * cxl_acpi  - initializes root decoders and interacts with ACPI data.
>  * cxl_p/mem - initializes memory devices
> -* cxl_pci   - uses cxl_port to enumates the actual fabric hierarchy.
> +* cxl_pci   - uses cxl_port to enumerate the actual fabric hierarchy.
>  
>  Driver Devices
>  ==============


