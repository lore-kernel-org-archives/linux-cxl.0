Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C34CC433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 21:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiCVVDk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCVVDf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 17:03:35 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D45506C9
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 14:02:05 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220322210200usoutp016b5715525da5a1b65b0e537423f291a6~ez7wzH2ev1172011720usoutp01B;
        Tue, 22 Mar 2022 21:02:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220322210200usoutp016b5715525da5a1b65b0e537423f291a6~ez7wzH2ev1172011720usoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647982920;
        bh=xiqTUNncz7wjQWq+KglyfnHfHwT3yCH0q5GtL+7LVXI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=hVH02Ga4uA5loLQlW5uuQJJLyzS1VEAiS5ywV3Qxm8tfj3ajoHOSkECNUWjXZPHZK
         s1/LNLIruotMq7MrzlWIYCVpzdiK/n51HsZgvRHJ0wbudD5TYw+85wM+fHWMoBu56v
         Ggo8+uIhk8RHq9eWeZsuFXYnwLNI5Kew9gVqiWaM=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220322210159uscas1p12fd48d028e8185497b8c8678a25935df~ez7vgW2jV1726217262uscas1p19;
        Tue, 22 Mar 2022 21:01:59 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id BA.C4.09760.7493A326; Tue,
        22 Mar 2022 17:01:59 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220322210159uscas1p2b7bfb832c275068e1a159cc1183057c2~ez7vPSKrA0977909779uscas1p2X;
        Tue, 22 Mar 2022 21:01:59 +0000 (GMT)
X-AuditID: cbfec36d-51bff70000002620-c3-623a39477310
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id FD.A9.09665.6493A326; Tue,
        22 Mar 2022 17:01:59 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Tue, 22 Mar 2022 14:01:58 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Tue, 22 Mar 2022 14:01:58 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 4/5] cxl/mbox: Use new return_code handling
Thread-Topic: [PATCH 4/5] cxl/mbox: Use new return_code handling
Thread-Index: AQHYPjARtXa0g70k/ES76DOkbulQ9A==
Date:   Tue, 22 Mar 2022 21:01:58 +0000
Message-ID: <20220322210158.GC198593@bgt-140510-bm01>
In-Reply-To: <20220317234049.69323-5-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AC01E53D5BCD14CA4786893347A51B8@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djXc7rullZJBvOOSFjcfXyBzaLrWT+z
        xfSpFxgtVt9cw2ix/+lzFovzs06xWNyacIzJgd1j8Z6XTB5TZ9d7fN4kF8AcxWWTkpqTWZZa
        pG+XwJXR9uYKW8EPvoqG1/sYGxin83QxcnJICJhIbP/3jrWLkYtDSGAlo8TpWfegnFYmifdr
        brPAVP38s40NIrGWUeLf5+nsEM5HRol3jT+YIJwDjBJvVq9jA2lhEzCQ+H18IzOILSKgLjFv
        7W1GkCJmgXNMEp1fW4GWcHAIC9hL/PnsC1HjIDH1/gk2CFtP4vS9f+wgNouAqsSbzlmsIDav
        gKnEod19TCA2p4C5xLOGH4wgNqOAmMT3U2vA4swC4hK3nsxngjhbUGLR7D3MELaYxL9dD9kg
        bEWJ+99fskPU60gs2P2JDcK2k7i58TorhK0tsWzha2aIvYISJ2c+gQaFpMTBFTdYQH6REDjD
        ITFz50uohIvE2sfTGSFsaYnpay5DFa1ilJjyrY0dwtnMKDHj1wWo86wl/nVeY5/AqDILyeWz
        kFw1C8lVs5BcNQvJVQsYWVcxipcWF+empxYb5qWW6xUn5haX5qXrJefnbmIEJqTT/w7n7mDc
        ceuj3iFGJg7GQ4wSHMxKIryLP5gnCfGmJFZWpRblxxeV5qQWH2KU5mBREuddlrkhUUggPbEk
        NTs1tSC1CCbLxMEp1cC06N3xTT5xL7+Hl0z6t9a4or3O1cDM+JOhkHD5LOXAbEVzb/ab17/u
        fFi76nmnsSPDilxWr1ebDq+4+Or9S/++/Nn7tngf5Z7FOMNc5/rnMK0DUc0628tacp6eNp2r
        ZruYv2bPLv5db2avfJ/is/voxH/8Vs5SE8sPf90dsedT2tLo5jcXSlXrytz6zs57G+gfdilB
        I3lVye7YqbILeh+79M544Ho3YVbJhfkdf/8v5rVkPhfocvfYtA9nTO9+yEq89j9rYZN65Pyo
        1gtpj7iDZk1p3/bm+qLPbdltXbyNz29ZCMys21DcGa70xsZn7q9D9yR930q+V1/kZ57yLk7y
        TM7B21NLN949mBEbzZb3XomlOCPRUIu5qDgRAMq125e3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWS2cA0Sdfd0irJ4M4DVou7jy+wWXQ962e2
        mD71AqPF6ptrGC32P33OYnF+1ikWi1sTjjE5sHss3vOSyWPq7HqPz5vkApijuGxSUnMyy1KL
        9O0SuDLa3lxhK/jBV9Hweh9jA+N0ni5GTg4JAROJn3+2sXUxcnEICaxmlFi+6DIzhPORUWL9
        9Y3sEM4BRon559pYQFrYBAwkfh/fyAxiiwioS8xbe5sRpIhZ4AyTxIdHl4E6ODiEBewl/nz2
        hahxkJh6/wQbhK0ncfreP3YQm0VAVeJN5yxWEJtXwFTi0O4+JhBbSCBZ4suFr2C7OAXMJZ41
        /GAEsRkFxCS+n1oDVsMsIC5x68l8JogXBCSW7DnPDGGLSrx8/I8VwlaUuP/9JTtEvY7Egt2f
        2CBsO4mbG6+zQtjaEssWvmaGuEFQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CM
        WsDIuopRvLS4ODe9otg4L7Vcrzgxt7g0L10vOT93EyMwjk//Oxyzg/HerY96hxiZOBgPMUpw
        MCuJ8C7+YJ4kxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcjdmK8kEB6YklqdmpqQWoRTJaJg1Oq
        gUn9gYPPW3eNrj8zeZr+LHF201pQdPv/1pjs9SLuD4xT2/2s+4LfKvBm77982ZgjJSB7sZvr
        ur0qUddTK3/Y7iyaa/eM87lu88THj1RS58UI7tlaHC9zufDKMt7w+adfHRC+vMPpmq377vis
        z0+5jzEH9W3tvrzJimuRhtanc9fPv/qlepjjLc8VcZ04kUONvsFddebV738bNTkEJIo0SFnW
        /t8cdveRkNXWpjyxE/N3lytvyc782+nuqruda7/L5f/uG+4eUPfnMei8GW6zyulsp+vhPl4p
        10sOV/c6PuCdmvMhhyPI6NGd7p1Gp3aV5mtvEr565e4F+fN/wo8YWJouZRP22H9oKq+oo9eR
        LCWW4oxEQy3mouJEAPn9P9pSAwAA
X-CMS-MailID: 20220322210159uscas1p2b7bfb832c275068e1a159cc1183057c2
CMS-TYPE: 301P
X-CMS-RootMailID: 20220322210159uscas1p2b7bfb832c275068e1a159cc1183057c2
References: <20220317234049.69323-1-dave@stgolabs.net>
        <20220317234049.69323-5-dave@stgolabs.net>
        <CGME20220322210159uscas1p2b7bfb832c275068e1a159cc1183057c2@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 04:40:48PM -0700, Davidlohr Bueso wrote:
> Use the global cxl_mbox_cmd_rc table to improve debug messaging
> in __cxl_pci_mbox_send_cmd() and allow cxl_mbox_send_cmd()
> to map to proper kernel style errno codes - this patch
> continues to use -ENXIO only so no change in semantics.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 7 ++++---
>  drivers/cxl/pci.c       | 3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d4d4a16820b7..fa9e7043f158 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -170,9 +170,10 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u=
16 opcode, void *in,
>  	if (rc)
>  		return rc;
> =20
> -	/* TODO: Map return code to proper kernel style errno */
> -	if (mbox_cmd.return_code !=3D CXL_MBOX_CMD_RC_SUCCESS)
> -		return -ENXIO;
> +	if (mbox_cmd.return_code !=3D CXL_MBOX_CMD_RC_SUCCESS) {
> +		int err =3D cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +		return -err;
> +	}
> =20
>  	/*
>  	 * Variable sized commands can't be validated and so it's up to the
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0c36d111232b..67ec0220826f 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -178,7 +178,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_sta=
te *cxlds,
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> =20
>  	if (mbox_cmd->return_code !=3D CXL_MBOX_CMD_RC_SUCCESS) {
> -		dev_dbg(dev, "Mailbox operation had an error\n");
> +		dev_dbg(dev, "Mailbox operation had an error: %s\n",
> +			cxl_mbox_cmd_rc2str(mbox_cmd));
>  		return 0;  /* completed but caller must check return_code */
>  	}
> =20
>=20
> --=20
> 2.26.2
>=20

Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
