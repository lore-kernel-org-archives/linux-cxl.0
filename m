Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25DA1A23AC
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199503; cv=none; b=CFf1OjZxm1vOzxKNNQlPaaDuRTtHI6KpGzZbgbbqUUvqt5guqDKCRaU14PL3w/LTga3KkAW25l/BGb/aoPQ8BBM5j2f7bv90XTamTfwOSZst+Q2zczMlekIJKhyRDAdTIHUNj2ZnS/whhwfahSmRcfpragUKGX8/x0bQH73X3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199503; c=relaxed/simple;
	bh=m3WRJxDvUdA8AgQX+7jPBPSBWUS42Js3jDU131Qoapk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+FEaxoo8LDRDLKhaO2P5WaaQnCb2TsUscJKBMop2sqsk3P/OF/NLDAd1YNFu7YaK1qNtkCvOhyobdwbPiCgOg0AxYNxhSDoi+SQ1dYwF7IijDeP+tI7JxuAAhCJZaH4KPLrRN0xCCDeendaiPSw0RuEkaLWUi6rLe9HarelfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fMqBj6gW1zHnH7c;
	Fri, 27 Feb 2026 21:37:33 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id D8A6D4056F;
	Fri, 27 Feb 2026 21:38:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Feb
 2026 13:38:19 +0000
Date: Fri, 27 Feb 2026 13:38:16 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: return appropriate error in
 cxl_payload_from_user_allowed()
Message-ID: <20260227133816.00003a59@huawei.com>
In-Reply-To: <20260220001618.963490-3-dave@stgolabs.net>
References: <20260220001618.963490-1-dave@stgolabs.net>
	<20260220001618.963490-3-dave@stgolabs.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Thu, 19 Feb 2026 16:16:18 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Make cxl_payload_from_user_allowed() return int such that the it can
> distinguish between different errors. The payload size failure is not
> well represented by EBUSY (exclusive access by the kernel).
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

If you are going to sneak in a fix to quotation style, then I'd like to see
it mentioned in the commit message.

Anyhow either way
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> +static int cxl_payload_from_user_allowed(u16 opcode, void *payload_in,
> +					 size_t in_size)
>  {
>  	switch (opcode) {
>  	case CXL_MBOX_OP_SET_PARTITION_INFO: {
>  		struct cxl_mbox_set_partition_info *pi =3D payload_in;
> =20
>  		if (in_size < sizeof(*pi))
> -			return false;
> +			return -EINVAL;
>  		if (pi->flags & CXL_SET_PARTITION_IMMEDIATE_FLAG)
> -			return false;
> +			return -EBUSY;
>  		break;
>  	}
>  	case CXL_MBOX_OP_CLEAR_LOG: {
>  		const uuid_t *uuid =3D (uuid_t *)payload_in;
> =20
>  		if (in_size < sizeof(uuid_t))
> -			return false;
> +			return -EINVAL;
>  		/*
> -		 * Restrict the =E2=80=98Clear log=E2=80=99 action to only apply to
> +		 * Restrict the 'Clear log' action to only apply to
Unrelated change. I don't mind it but should at least be mentioned.
Maybe Dave can add something to the commit description when picking this up.


>  		 * Vendor debug logs.
>  		 */
> -		return uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID);
> +		if (!uuid_equal(uuid, &DEFINE_CXL_VENDOR_DEBUG_UUID))
