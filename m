Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2B5192D94
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015598; cv=none; b=qc1ygurWyfgQN1CkTWAAv+li1e5iJNmAaLgNvzaoD8kEwEVN4ss9alxwx1mG1ZIfd+k2SvXvvg7zvxLnRdEtu3YzQCtqX5J5C8hABqna15ReBleLlYxY3H2VJdjzLAnn70T2+hpYn7NgzyaNT2Lw3CmUklKZ6+/y6/fUHwXPvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015598; c=relaxed/simple;
	bh=w83Ph7x7U3NZ46UIH11HBjnKcG1nKZwVzVekM+bHgVk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pqk55DoqCO0KeAAtjDkBQIGBTMxBAqyoazNRsY41t8ufCuLphlr9p40hCdoQtuRjviqML/z8qglMrgDH7mXyurgTFTgEMt2hTmaarQTyFqgGjcThaq6u1Ku7QfajIj9hrkAmel/XADmalgWOow/KzntalKPebAFrdtiJ4REK6Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFS10mYbz6K6WT;
	Fri, 30 Aug 2024 18:55:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A2BB1140CF4;
	Fri, 30 Aug 2024 18:59:52 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 11:59:52 +0100
Date: Fri, 30 Aug 2024 11:59:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
	<peter.maydell@linaro.org>, <devel@edk2.groups.io>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <chenbaozi@phytium.com.cn>,
	<wangyinfeng@phytium.com.cn>, <shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH edk2-platforms 1/2] SbsaQemu: Add acpi0016 &
 acpi0017 objects into DSDT
Message-ID: <20240830115951.0000783b@Huawei.com>
In-Reply-To: <20240830031545.548789-2-wangyuquan1236@phytium.com.cn>
References: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
	<20240830031545.548789-2-wangyuquan1236@phytium.com.cn>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 11:15:44 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> This adds relevant definitions and descriptions of acpi0016 and
> acpi0017 to support CXL.
> 
> With the implementation of pxb-cxl on the original pcie host bridge,
> the previous space layout of mmio32 & mmio64 have to be divided to
> provide the mmio space for cxl host bridge.
> 
> I'm not sure if the new space layout would bring a series of bad
> influence, but it seems that the base address and size of cxl host
> bridge is ok.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

I'll go as far as saying this looks about right to me, but needs
some more eyes to be more certain. 
Trivial comments inline.

Jonathan

> diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
> index c134fb66e860..94d0b2cbb118 100644
> --- a/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl
> +++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Dsdt.asl

> @@ -483,5 +849,45 @@ DefinitionBlock ("DsdtTable.aml", "DSDT",
>          }
>        } // End _OSC
>      }
> +
> +    Scope (\_SB)
> +    {
> +        // CXL Root for OS Driver
> +        Device (CXLM)
> +        {
> +            Name (_HID, "ACPI0017")  // _HID: Hardware ID
> +            Method (_STA, 0, NotSerialized)  // _STA: Status
> +            {
> +                Return (0x0B)
> +            }
> +
> +            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> +            {
> +                If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52") /* Unknown UUID */))
Name that UUID in the comment.  I was thinking you didn't have QTG querying supported
because oddly I can't remember the uuid :)

> +                {
> +                    If ((Arg2 == Zero))
> +                    {
> +                        Return (Buffer (One)
> +                        {
> +                         0x01                                             // .
> +                        })
> +                    }
> +
> +                    If ((Arg2 == One))
> +                    {
> +                        Return (Package (0x02)
> +                        {
> +                            One,
> +                            Package (0x02)
> +                            {
> +                                Zero,
> +                                One
Hmm. I probably have this wrong in the qemu code, but it should be safe.
This is saying QTG 0 default with fallback to 1.  We don't have anything
in group 1.
Ah well never mind.  
> +                            }
> +                        })
> +                    }
> +                }
> +            }
> +        }
> +    }
>    } // Scope (_SB)
>  }



