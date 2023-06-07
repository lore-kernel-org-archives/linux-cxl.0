Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81881C8300C
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 16:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFGQsD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFGQsC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 12:48:02 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFB1FDB
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 09:47:59 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230607164757usoutp01c9194848b17a102a53e035c913cf5c36~mbmHiVGaf3081930819usoutp01z;
        Wed,  7 Jun 2023 16:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230607164757usoutp01c9194848b17a102a53e035c913cf5c36~mbmHiVGaf3081930819usoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686156477;
        bh=JoWSuYmJY0dh+Hlk6FOx2Qac52ISNovEL7f36KD62eg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=gpZW7HtzY26ywig4VfOMkCp+Xky8P/F7oRp1BtiIiFc+yrO3l/dVR84oCpX1rBtFt
         8XQ/temE5KCu0IK/P7neFmCR0haqEuNYsPBrASOQUIucGAw6dvOpbxPcPo9ChkusiN
         46VwhZyVDsmlUEeHP8Kl7QK2WKYJ6fP9VlULIcRc=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230607164757uscas1p2b7c47af0b850a1dec9670ef9328be737~mbmHYI2qg3208832088uscas1p25;
        Wed,  7 Jun 2023 16:47:57 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 64.CB.62237.CB4B0846; Wed, 
        7 Jun 2023 12:47:56 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230607164756uscas1p2fb025e7f4de5094925cc25fc2ac45212~mbmG7n2TV2679126791uscas1p2J;
        Wed,  7 Jun 2023 16:47:56 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-90-6480b4bc74a8
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 85.F6.38326.CB4B0846; Wed, 
        7 Jun 2023 12:47:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 7 Jun 2023 09:47:55 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        7 Jun 2023 09:47:55 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: Re: [PATCH 09/19] cxl/memdev: Formalize endpoint port linkage
Thread-Topic: [PATCH 09/19] cxl/memdev: Formalize endpoint port linkage
Thread-Index: AQHZmV/O6+j5zHA1fEWUZrMZGYq2DA==
Date:   Wed, 7 Jun 2023 16:47:55 +0000
Message-ID: <20230607164748.GA2354150@bgt-140510-bm03>
In-Reply-To: <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C14F0F4A460AA547A0F0F87082BA6881@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzred09WxpSDH7/NbOYPvUCo8X+p89Z
        LM7POsVicXzNBFYHFo/Fe14yeXzeJBfAFMVlk5Kak1mWWqRvl8CVsfbxPJaCKwoVS6eeYmpg
        vCPVxcjJISFgItGwbD1zFyMXh5DASkaJuxPfsEM4rUwS957+ZIap+te9H8wWEljLKDHtlQBE
        0UdGiXMHjkJ1LGWUeP1zBTtIFZuAosS+ru1sILaIgLbExDkHwXYwCyxklPj1/jpYQljATeL1
        43bGLkYOoCJ3ib1XlCDq9SQ6zp9mAbFZBFQkps8/CbaZV8BMYuvzKWDzOQXCJbYt+AM2hlFA
        TOL7qTVMIDazgLjErSfzmSCuFpRYNHsP1AdiEv92PWSDsBUl7n9/yQ5RryOxYPcnNgjbTmLq
        9n8sELa2xLKFr6H2CkqcnPmEBaJXUuLgihssIL9ICKzlkPh2bC9UwkXi5IyFUAukJa5en8oM
        8peEQLLEqo9cEOEciflLtkCVW0ss/LOeaQKjyiwkZ89CctIsJCfNQnLSLCQnLWBkXcUoXlpc
        nJueWmycl1quV5yYW1yal66XnJ+7iRGYYk7/O1ywg/HWrY96hxiZOBgPMUpwMCuJ8GbZ16cI
        8aYkVlalFuXHF5XmpBYfYpTmYFES5zW0PZksJJCeWJKanZpakFoEk2Xi4JRqYJIyy0zNapMs
        u2knfYk7chlfAlf9NftLh97WBoavWP8iVHBW6f9P2+9tnHZMveB/2t+cj3qciydv2qT2K+7a
        IuWY0FrrdwFL8hemCy4NX690unlL3vn1Bx1vdEz9YHNxq4+uhlbvK6MaM6/XjYYM9pqH7BsM
        GYWZj92sn8WpdbWZNeasxRnBu1/Pql2OYxOfprFncoW+gHr65VwJ/1lyJUHhhUwvz36tfhB5
        s/pl32QGr79rj/ul39+wsW/5B2O34K178r/PuW9QuPe4RtA8x6Lk64eWP57g8TYr71rdDoUd
        C6MEg17/sM5fPMkw2/In58cpaiGMSRpbNgkUP9//ea4MYwXLjMkl734f/Xxc8pUSS3FGoqEW
        c1FxIgCC3XlgoAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWS2cA0UXfPloYUgzubpCymT73AaLH/6XMW
        i/OzTrFYHF8zgdWBxWPxnpdMHp83yQUwRXHZpKTmZJalFunbJXBlrH08j6XgikLF0qmnmBoY
        70h1MXJySAiYSPzr3s/cxcjFISSwmlGifeISJgjnI6PE0ltHWCGcpYwSd19fYgFpYRNQlNjX
        tZ0NxBYR0JaYOOcgWDuzwEJGiV/vr4MlhAXcJF4/bmfsYuQAKnKX2HtFCaJeT6Lj/GmwOSwC
        KhLT559kBrF5Bcwktj6fwg5iCwksZpS491gexOYUCJfYtuAP2EhGATGJ76fWMIHYzALiEree
        zGeCeEFAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSCzY/YkNwraTmLr9HwuErS2xbOFrqBsE
        JU7OfMIC0SspcXDFDZYJjBKzkKybhWTULCSjZiEZNQvJqAWMrKsYxUuLi3PTK4oN81LL9YoT
        c4tL89L1kvNzNzECI/T0v8OROxiP3vqod4iRiYPxEKMEB7OSCG+WfX2KEG9KYmVValF+fFFp
        TmrxIUZpDhYlcV4h14nxQgLpiSWp2ampBalFMFkmDk6pBqbqM+yFBfI/CjxFsrdrTncsidR+
        rq5v7iusGPouvCuAIS5x/1vjD2sm76r+YvHc9dNJiTcZqTUMvErd+xckhCz3ur/u+6ey1b/3
        FeSbbslYFhXzi0HkXoabX73/PQOJvqyarYt26bz2T5tg522keyTBb2noohWXJAJjee2v6T1b
        z8E16+jujXp15mt633xnupKvoidxh+nm3TPsD+sv7XXlm797v77me5kl8e9+RITNC/HwanbY
        eFj6VWnpk//7t/V7XVGdvZpFsaRO58Cks5OFT9x/vKjIZXVqYZ3sbDb5DMuWFI7AhsP8XLwb
        BN6JREY3p/9Ys9xeJcZ2Uh171XOLX5qpSurzqoze/03jVGIpzkg01GIuKk4EAK0baoc/AwAA
X-CMS-MailID: 20230607164756uscas1p2fb025e7f4de5094925cc25fc2ac45212
CMS-TYPE: 301P
X-CMS-RootMailID: 20230607164756uscas1p2fb025e7f4de5094925cc25fc2ac45212
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592154692.1948938.3074738916245299862.stgit@dwillia2-xfh.jf.intel.com>
        <CGME20230607164756uscas1p2fb025e7f4de5094925cc25fc2ac45212@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Jun 04, 2023 at 04:32:27PM -0700, Dan Williams wrote:
> Move the endpoint port that the cxl_mem driver establishes from drvdata
> to a first class attribute. This is in preparation for device-memory
> drivers reusing the CXL core for memory region management. Those drivers
> need a type-safe method to retrieve their CXL port linkage. Leave
> drvdata for private usage of the cxl_mem driver not external consumers
> of a 'struct cxl_memdev' object.
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/memdev.c |    4 ++--
>  drivers/cxl/core/pmem.c   |    2 +-
>  drivers/cxl/core/port.c   |    5 +++--
>  drivers/cxl/cxlmem.h      |    2 ++
>  4 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3f2d54f30548..65a685e5616f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -149,7 +149,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	struct cxl_port *port;
>  	int rc;
> =20
> -	port =3D dev_get_drvdata(&cxlmd->dev);
> +	port =3D cxlmd->endpoint;
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
> =20
> @@ -207,7 +207,7 @@ static struct cxl_region *cxl_dpa_to_region(struct cx=
l_memdev *cxlmd, u64 dpa)
>  	ctx =3D (struct cxl_dpa_to_region_context) {
>  		.dpa =3D dpa,
>  	};
> -	port =3D dev_get_drvdata(&cxlmd->dev);
> +	port =3D cxlmd->endpoint;
>  	if (port && is_cxl_endpoint(port) && port->commit_end !=3D -1)
>  		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
> =20
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index f8c38d997252..fc94f5240327 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -64,7 +64,7 @@ static int match_nvdimm_bridge(struct device *dev, void=
 *data)
> =20
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlm=
d)
>  {
> -	struct cxl_port *port =3D find_cxl_root(dev_get_drvdata(&cxlmd->dev));
> +	struct cxl_port *port =3D find_cxl_root(cxlmd->endpoint);
>  	struct device *dev;
> =20
>  	if (!port)
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 71a7547a8d6f..6720ab22a494 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1167,7 +1167,7 @@ static struct device *grandparent(struct device *de=
v)
>  static void delete_endpoint(void *data)
>  {
>  	struct cxl_memdev *cxlmd =3D data;
> -	struct cxl_port *endpoint =3D dev_get_drvdata(&cxlmd->dev);
> +	struct cxl_port *endpoint =3D cxlmd->endpoint;
>  	struct cxl_port *parent_port;
>  	struct device *parent;
> =20
> @@ -1182,6 +1182,7 @@ static void delete_endpoint(void *data)
>  		devm_release_action(parent, cxl_unlink_uport, endpoint);
>  		devm_release_action(parent, unregister_port, endpoint);
>  	}
> +	cxlmd->endpoint =3D NULL;
>  	device_unlock(parent);
>  	put_device(parent);
>  out:
> @@ -1193,7 +1194,7 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlm=
d, struct cxl_port *endpoint)
>  	struct device *dev =3D &cxlmd->dev;
> =20
>  	get_device(&endpoint->dev);
> -	dev_set_drvdata(dev, endpoint);
> +	cxlmd->endpoint =3D endpoint;
>  	cxlmd->depth =3D endpoint->depth;
>  	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b8bdf7490d2c..7ee78e79933c 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -38,6 +38,7 @@
>   * @detach_work: active memdev lost a port in its ancestry
>   * @cxl_nvb: coordinate removal of @cxl_nvd if present
>   * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
> + * @endpoint: connection to the CXL port topology for this memory device
>   * @id: id number of this memdev instance.
>   * @depth: endpoint port depth
>   */
> @@ -48,6 +49,7 @@ struct cxl_memdev {
>  	struct work_struct detach_work;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_nvdimm *cxl_nvd;
> +	struct cxl_port *endpoint;
>  	int id;
>  	int depth;
>  };
>=20
> =
