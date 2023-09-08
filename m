Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3F7EEB560
	for <linux-cxl@archiver.kernel.org>; Fri,  8 Sep 2023 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbjIHSqJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 8 Sep 2023 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjIHSqJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 8 Sep 2023 14:46:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ADF1705
        for <linux-cxl@vger.kernel.org>; Fri,  8 Sep 2023 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1694198665; x=1694803465; i=fan.ni@gmx.us;
 bh=kST+ls3nKHZ/U/2j2Xqf7o6XZANd+WQVzYpVKm9BZrE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CDPL1MfusPKiU/8mGjdNGHGMEz69Wi24TrIrQPNq/AXfj4W3saBAYkpwz/0cTJLlPSeIu7K
 8+OjyPYg13sxz7pC7KoLEFhL7CfC4ennwSpCrGEJHNhDwL06xGCESBFj7S/JfHa7t+7y9tQda
 /mju81Pm1vNaFPyPGSQ4lwWVVuJ4dwzyL+r/kvpPl4+f7sWoLYPl6QKvV/AEV0pSZTNfHO70c
 /4ytl/aXtJFGT3v0M8dv2BtHt8UqOJrF1wFJNRdzkXO25Zag03BuMTYo5QFcdtvVfh4D212rt
 UHMwnH2I8Bh0j8xGZ8rsU9Cestt/vnUDMAp6RpOnYwH791N7ZTpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mw9QC-1pp3eB0Htk-00s9I2; Fri, 08
 Sep 2023 20:37:47 +0200
Date:   Fri, 8 Sep 2023 11:37:31 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        dan.j.williams@intel.com, alison.schofield@intel.com,
        ayush.m55@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/4] cxl/type3: Fix crash in set_cacheline()
Message-ID: <ZPtp63VmaKHl+G+K@debian>
References: <20230908073152.4386-1-dave@stgolabs.net>
 <20230908073152.4386-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908073152.4386-2-dave@stgolabs.net>
X-Provags-ID: V03:K1:C6eFLosYfrC/b7MG0y0zadMzEtrR7ZjWWyrb+fzunEt5IaxVbLm
 SV0fzFYmjLOErC6D3wCOJDklfyW997u11JmXTSsMancIVb347afGcC/zITROWz/MhMEvUla
 87IR71FszT0VAMeYDqsrmIvGf+5os0eX+sWsJNS7dP6X5/HGS1rNbS9zlnO9Ih40IYBPJjd
 aQ041tm+lcYavTO/d56KQ==
UI-OutboundReport: notjunk:1;M01:P0:0Xdv2lzf6wg=;/M+MzfpwK5xnYIwLGWx2wMZFn0O
 0nxKlDfYDh6nmZ/csqH/yIMnCcL1orsAY6d0nc40kTbECcpRGc1Fj9JR4oFXtZj0L4i4pi5Uv
 b3JJPaodT5qpQaG5cKq948OSv+jD0k5OGJaRDhO5F/5voQlRjKzIZGDVb9hBKL02jMyfYiemz
 ePlMUpRrf0ygE/7/1WUVka7bm8fERzgQvcpJVknQxLIYIhghXd7hECerSQBPV6WHb+zm1QMPx
 mA9ef66NBxmrUgstf6k7oQrKTyKtjJIyhG0vTaip+FJhs5HvbYZ/DWwm4vjFNwDiIWctlF4kl
 K5LAGIXUcerfFSBV8yb5bFAyTplxiAixP0d4eWIyvC/W3/RtPg2JWJDhd9Hq4z1p0S0ZJ3cw9
 O2YtdJ+WN7yU3K2xX8CBBU7MVlVuY+ALW3EK5CCTLm+Do408W5XAHO8P3JO8tSZhSAsD0lPo8
 9uPH4p64v2e+PegdvxtOb31tHy3ChyHhz2UIKm98uQBqroxFIwNe/Ln2AbQmIwmgbQq+Xstwp
 9KEM/wHFX1BlYtHmFQC9z000yMhnB/8QDAAzbPL1nzQrJmPRFyrd5BQtImmDIDOhoIzR7BPRG
 uJtcqlpZAZiBhc59RR4Nrrm4eWq+o5E1V9alrVZO6HHmmVRLawk0VfXJiGc47r6Xj/ri7ODSi
 xaqqHmOLT/OsEyiUrIZz29Myw4lbwmmavaJPuz9k0vvN7OuHs2h/jdpHf3/zwoIOlnKGJFuxi
 BXIALBgJLo8G3NORFaWD9xRyZ3BUTIQFJZvJmtYKg8ZTaYUYF4AWXUE9ITsVnBGStTrJEq+Vi
 woYGHeBqvcQEsJG1vGTPQNNrq4bzbPwIbAPSGOTOzgjOXaQZeAyATCz8Tq6BVKDc50YkHwLfE
 gUisKjHEo9sr2eUnQ9SCBG3sgGAFZEpAigIzfhTUlNkW9oT5CWone0BOxau2feIALgru0Bcg2
 7ySKFnvIQ6Jdj8Rb5X3VSvVmMcc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Sep 08, 2023 at 12:31:49AM -0700, Davidlohr Bueso wrote:
> Use the correct vmr_size, otherwise a clear poison operation, for
> example, can crash the emulator.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index fd9d134d468f..b90a7397d62f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1417,7 +1417,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint6=
4_t dpa_offset, uint8_t *data)
>          as =3D &ct3d->hostvmem_as;
>      } else if (dpa_offset < vmr_size + pmr_size) {
>          as =3D &ct3d->hostpmem_as;
> -        dpa_offset -=3D vmr->size;
> +        dpa_offset -=3D vmr_size;

Good catch. It is a typo from my DCD patch, not upstreamed yet.

Fan
>      } else {
>          as =3D &ct3d->dc.host_dc_as;
>          dpa_offset -=3D (vmr_size + pmr_size);
> --
> 2.42.0
>
