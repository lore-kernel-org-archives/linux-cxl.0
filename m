Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1647FC4708E
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 21:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjACVn0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 16:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjACVnY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 16:43:24 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A3AB48E
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 13:43:20 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230103214314usoutp017ad40ecf154d3dcaf317c8532bf18e04~26or-OBUL2633926339usoutp01C;
        Tue,  3 Jan 2023 21:43:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230103214314usoutp017ad40ecf154d3dcaf317c8532bf18e04~26or-OBUL2633926339usoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672782194;
        bh=Fb+AOtsztx2PL9uuG7lK4bgYrZE6XVdEyWZTIn8HsMY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Zs2EvvnCd1EDw7Lj8QBEMsp+FYLNXJowQUjRl5VkxKiJdkka5FeT8ivVPM/UnnRGn
         bNVwLO2A74gJPHkG+vjBuz2oNLL8isJAw/q8VNrYnCFyEgh3+g5NGVDnlrX4NJD1IB
         YIgex6W6AW2M8hafGQF5pyWyZhp+6XiCDvNlpOcE=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230103214314uscas1p2b6624286967e849f08a4e16e3321d188~26or4_Zcz1282312823uscas1p27;
        Tue,  3 Jan 2023 21:43:14 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 96.BB.34012.271A4B36; Tue, 
        3 Jan 2023 16:43:14 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230103214313uscas1p17c4ed9498d0168080896001306548a96~26orqMDpD2956429564uscas1p1S;
        Tue,  3 Jan 2023 21:43:13 +0000 (GMT)
X-AuditID: cbfec370-70dfe700000284dc-78-63b4a172d439
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id FA.C2.03790.171A4B36; Tue, 
        3 Jan 2023 16:43:13 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 3 Jan 2023 13:43:13 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        3 Jan 2023 13:43:13 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>
Subject: Re: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph images
Thread-Topic: [ndctl PATCH 0/2] cxl-list: Construct CXL topology graph
        images
Thread-Index: AQHZFKCOrtu2YggNCUSipmQFAN4BWK6NqYMAgAAsFAA=
Date:   Tue, 3 Jan 2023 21:43:12 +0000
Message-ID: <20230103214305.GA2878607@bgt-140510-bm03>
In-Reply-To: <63b47c72a3cc4_5174129497@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0472EB316367DB4DB527768C54C92B62@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH+z7Pc3dPZzffrqaPWHTLhpSfcUJjY7L8aEOEHbfzLNE93e4p
        lKZEzHNqhRPPhcrkR1eR0E9RVmSWEepEYzFHmx3LMa1xz5Pt/nt/P5/X5/t9fb/70qT6rCyI
        TmJTGTOrT9bIldSd9qGucHNprWHW0TaFtsj6DGkreu1I2yV0UtpDv8uQ1lHQTiyVxdQLbxUx
        l5qcRIzVlhXzoyY4jtqiXLyTSU7ay5hnRu9Q7ho4fMD0ImT/L2eRIhv9DuIRTQOeBz9zxvBI
        SavxNQTNeRUKaZFLwJdHVjmPfEXI3cuLWY0rEYwcD5EgF4L+XispLS4jOFZRJFJyHAL3+Lti
        DsBhUFj8QIRIPILA3vJdbPjj1VBqbyE8HgF4HeS50iQ+CupdxSJC4VA4ct9FeRAVng+ufJ2n
        7ItXAf9HID0Z4XHg7rQTnkziQHAMXCQkaT8oszWRUh4HIw3vRy8TAv1up0LiZ0BJo2RD4mjg
        j35DUg6D8tKv4qzq3z6Pzw1Q0ux4eHC1ZzQ/pOFZQ6j0isuh8NESqTwBXr62jh7LwZNzTvHm
        gLMRVPX1yKTGIigdriYKUKjgpS14KQleSoKXkuClVIJk11FgGscZExluLsvsi+D0Ri6NTYww
        pBhr0L/P82SkzVSHHA5XRCsiaNSKgCY1AaqTn2sMatVOfXoGY07Zbk5LZrhWNIGmNIEqy+2L
        BjVO1KcyexjGxJj/dwnaNyibYLHc0iwou+91ZXZMzbXUDa6t7/hzel1ktLPKLpvbJc+5md7W
        vX7mtkLAC/3irZE9yKcxcjihrH73tHabqaUif8Bh6zYMFx3I5xfqhqrmVKayMtJtD47T9TeF
        ZeyIimc3PtYc22pe4R6bcEnXefJF+RRtVvWVAA3qiO3ZQw9N8r9VudIiPxW3+932T87zB+vC
        eveNb2DjDT6hU2ZssW39NdH6XH+iUHsmY/7kgiS/E3SqLri224iiU0435Vq0fPEa18bwp5sH
        H/bpuDdU1oLmO8KGvKiSVx82WdiPb68Zbzj3Z1abnMOD6XMac6pUseVLYi8YfFa8zFx2g5kN
        fYKG4nbpZ08nzZz+L2GAIeirAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsWS2cA0Ubdw4ZZkg6aTxhbTp15gtFh9cw2j
        xflZp1gsGn8uYrS4NeEYkwOrx85Zd9k9Fu95yeQxdXa9x+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        T5qrCy4rVvx4OZ29gfGnVBcjJ4eEgInE95tdbF2MXBxCAqsZJT52HWECSQgJfGSUOPYyFCKx
        lFFiz4QFbCAJNgFFiX1d28FsEQFtiYlzDjKDFDEL/GOUWLP/E1hCWMBHYuGa/UwQRb4Sbace
        M0LYVhI7P84Bq2ERUJFoOfCRpYuRg4NXwEziY18cxLIzjBK37p8Gq+EU8JTo+j2LGcRmFBCT
        +H5qDdhMZgFxiVtP5jNBvCAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIep1JBbshriNWcBOoqvt
        PSOErS2xbOFrsF5eAUGJkzOfsED0SkocXHGDZQKjxCwk62YhGTULyahZSEbNQjJqASPrKkbx
        0uLi3PSKYsO81HK94sTc4tK8dL3k/NxNjMDYPf3vcOQOxqO3PuodYmTiYDzEKMHBrCTCO+nF
        pmQh3pTEyqrUovz4otKc1OJDjNIcLErivEKuE+OFBNITS1KzU1MLUotgskwcnFINTJ0h6ncS
        iyN1Zi9mKloyl6m1cM9VW2f230V8bf2zTdIvsefZGK8s5g10ev9R6a/x/f5nO9sXJHE/Vbl+
        wa5m/ZTEi5a2vZsS34W8MA38vPbcqnmXsjjkzJWPbbgamfPINqZO0ML/7rdF+xd9+sw2/8ul
        ss2ZcuKeH2VlZEVK9d6nsTNu3P35xNR5gT/fuFd/nLZRhkPvQCvzwg3ueRLstXWbNHKdrIwO
        pM5WvDfrplGAvt+KnSYbNmzqs9O+Nu2sX/uGdJWf8sm7epVl5sp39K/zufzS86H63F0zb09n
        z8/OdLvKLWwVp6loqdZVamxdV+d5Qs/X4LliPrvtpv32nXOk2Fyr939cFjvnFyODEktxRqKh
        FnNRcSIAJ4wgp0wDAAA=
X-CMS-MailID: 20230103214313uscas1p17c4ed9498d0168080896001306548a96
CMS-TYPE: 301P
X-CMS-RootMailID: 20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c
References: <CGME20221220182621uscas1p22da97d084545a7b00f7bf7ea4df7ee3c@uscas1p2.samsung.com>
        <20221220182510.2734032-1-fan.ni@samsung.com>
        <63b47c72a3cc4_5174129497@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 03, 2023 at 11:05:22AM -0800, Dan Williams wrote:



> Fan Ni wrote:
> > This patch series extends the `cxl list` subcommand to show the cxl
> > topology visually. Mattew Ho first worked on the code and provided an
> > initial patch as list below[1].
>=20
> Thanks for picking this up, it looks like a useful addition to me.
>=20
> >=20
> > This patch series includes the following two patches,
> > 1) Patch 1 adds a parent_dport attribute to ports and type 3 memory dev=
ices to
> > show which downstream port a component is attached. This attribute will=
 be used
> > in patch 2 to generate the cxl topology graph.
>=20
> I had a similar patch to do this here:
>=20
> https://urldefense.com/v3/__http://lore.kernel.org/r/167053491908.582963.=
7783814693644991382.stgit@dwillia2-xfh.jf.intel.com__;!!EwVzqGoTKBqv-0DWAJB=
m!Xc_tWtX0GBqionoq7JRQxQ39MytJEW3jP-JcQnLrj7Op9_u5mMRg_hUoUvQabHNT_IXi3MbHF=
2d0TwCsiZckhvCToA$=20
>=20
> The biggest difference I see is that your version adds 'parent_dport' to
> memdevs where mine keeps it purely an 'port' attribute. So the listing
> needs to have --endpoints to get the memdev to 'parent_dport'
> assocation.

Thanks for mentioning this, I missed the patch. It seems we can use this pa=
tch
to prepare the info for plotting the graph. Need to check more.

>=20
> > 2) Patch 2 extends the `cxl list` subcommand to dump the cxl topology t=
o a
> > json format file or generate a graph showing the cxl topology. To use t=
he
> > extended function, the option `-o output.suffix` is added. Acceptable o=
utput
> > suffixes include .jpeg, .jpg and .png for generating a graph and for ot=
her
> > suffix, it will dump the json-formatted cxl topology to the file, which
> > can be used the input file (with --input option) to generate the graph
> > later.
>=20
> I notice that the implementation enforces some implicit listing options,
> disables --endpoints, and does some magic with looking at the suffix to
> know what to write to the output file. That feels too restrictive and
> makes the 'list' command a bit more difficult to reason about. How about

Using file extention to decide whether to dump the output to a json-formatt=
ed
file or plot a cxl graph was suggested by Vishal in his previous
comments to Mattew's patch (
https://lore.kernel.org/all/093ebf126ad44920d9c7bfd1c30af5040e0c7020.camel@=
intel.com/
). We are neutral to either way as long as there is a consensus.

About the enforcements placed on "cxl list" command option, it should be ea=
sy to
address. We should be able to remove them and fix in graph functions.

> decoupling the support from 'list'? I am thinking of a scheme like this:
>=20
>    cxl list -vvv | cxl graph -o png > cxl-topo.png
>=20

Currently, we can do similar things as you mentioned above.
cxl list -vvv > cxl.json (with some changes to remove the option enforcemen=
t.)
cxl list -input cxl.json -o cxl-topo.png

But I agree that using a separate subcommand may be a better idea as the
advantage you mentioned below.

> This has a few advantages:
> - The graphviz build dependency can be made optional where the user can
>   detect if the support is present in the build by the availability of
>   the 'graph' subcommand.

IMO, this is the main advantage to introduce a new subcommand.

> - Listings can be created on one system and graphed on another which
>   among other usages is useful for debugging topologies over email.

Our current approach can achieve similar goal with "-input" option.

> - The 'graph' subcommand can parse and optionally warn about the input
>   json rather than implicit forcing of listing options.

Agree.

> - The json can go through additional filtering before being graphed:
>=20
>     cxl list -vvv $basic_filters | jq $advanced_filters | cxl graph -o pn=
g > out
>=20
> Thoughts?

Thanks for the comments. So based on the above comments and my
understanding, I think we need to decide two things before acting
further.
1. whether we want to use suffix to determine plot behaviour or use
explicit arguments.
2. Whether we want to introduce an extra subcommand for the graph
function or stick to existing approach and make changes as needed to
achieve similar goal.=
