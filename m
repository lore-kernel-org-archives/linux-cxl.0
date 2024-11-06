Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48710208202
	for <linux-cxl@vger.kernel.org>; Wed,  6 Nov 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916826; cv=none; b=UbXIhlLoyyecoQuZy8DtQBYB3rmqmiRP7NiUOovW+Pr1Co+XUrGz99v9ZW6hn3n3JFoO/TK0jTxkwNR245z4k09jIycwHLhR9ML6Cnb9UhDN2fGSlSIsA6O6rP19+SYSXuHJSInc1u0IHMALG0DhfwyFT0uRKBgRJ/RlDTU8akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916826; c=relaxed/simple;
	bh=vE/kJ0z2/UjaJg6Qu7Qo2KQQFroBM20WR7WQ/Q2IQTw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POiZDpHGSERVfymgZni9t279dkmSFh1Q25r+0T51fkwqrseisioNaGIXHeGGwVZQAghQX7UkOd+gOsDRaVoRSye+4jX1o1EMVl+d8Rex/h3bqJalUTtcWBO07mNHdQmS6Fd0XkOnNwqfoenPm2v/STQ3mydto7+wgNbcdcfwscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XkCth6k3fz6K7CK;
	Thu,  7 Nov 2024 02:10:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DF968140A77;
	Thu,  7 Nov 2024 02:13:40 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Nov
 2024 19:13:40 +0100
Date: Wed, 6 Nov 2024 18:13:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<linuxarm@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, <eduardo@habkost.net>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v6 10/15] hw/acpi: Generic Port Affinity Structure
 support
Message-ID: <20241106181338.00003c37@Huawei.com>
In-Reply-To: <20240916174122.1843197-1-Jonathan.Cameron@huawei.com>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
	<20240916174122.1843197-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)


> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 968b654e58..4aa4debf44 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1955,6 +1955,19 @@ static void build_append_srat_pci_device_handle(GArray *table_data,
>      build_append_int_noprefix(table_data, 0, 12);
>  }
>  
> +static void build_append_srat_acpi_device_handle(GArray *table_data,
> +                                                 const char *hid,
> +                                                 uint32_t uid)
> +{
> +    assert(strlen(hid) == 8);
> +    /* Device Handle - ACPI */
> +    for (int i = 0; i < sizeof(hid); i++) {

Here is the bug that is tripping the test on a 32 bit host.
That sizeof(hid) is garbage (I'm guessing a result of messed up
factoring out of this code from where it was an array of
characters).

Should just be 8. 

I'll run tests and send out fix by end of week.

Jonathan



> +        build_append_int_noprefix(table_data, hid[i], 1);
> +    }
> +    build_append_int_noprefix(table_data, uid, 4);
> +    build_append_int_noprefix(table_data, 0, 4);
> +}
