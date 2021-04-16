Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771D8C433B4
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495C36113B
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhDPCms (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDPCmr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Apr 2021 22:42:47 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06FFC061574
        for <linux-cxl@vger.kernel.org>; Thu, 15 Apr 2021 19:42:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FM0qH61dTz9sWK;
        Fri, 16 Apr 2021 12:42:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1618540939;
        bh=ezq2Uubd0fN2go8CyvQD+/oNvIRjb4awfLp1u+Kkvao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KT3+Qv7VFhsFYy//8OhIgpRjY/Cy5aiw49W94jUVjQSh1yBZj0Ni6bUvC4fEUg352
         h6Muhlia3Zq9rV/azbUOsi9skWxsId7Gr4kHTt/gf8kYFVQdHRTt63vfZLdsQ6eHJJ
         Tuq3w2tmlgiFt5Fe9jFj4FshBq7yv8HedL7AAOICcpTBh+8bw3EcZC8y3+STNs8pFQ
         w/zlq4aXFQ9bFIr0KaDmXyAYDtg5HQrL0yfYyLsAt3gSzlirUALltWYuSgEZLw51Wj
         iWAxdl95udQCEEVkoSWkPu7+97YYXsFO0qcQkmqOR1c5BLO9mFiyI8bOjSCZoo+BET
         M8V0cH7IG6k7w==
Date:   Fri, 16 Apr 2021 12:42:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: CXL Trees for linux-next
Message-ID: <20210416124218.0868cc9d@canb.auug.org.au>
In-Reply-To: <CAPcyv4iTBKXAEt=6uxenWgn-9GDSC0tH0Riq5167pVdTJ0208w@mail.gmail.com>
References: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
        <20210416120905.19211c7c@canb.auug.org.au>
        <CAPcyv4iTBKXAEt=6uxenWgn-9GDSC0tH0Riq5167pVdTJ0208w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/utP3tWSeyfy6r.abbEvAgUI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

--Sig_/utP3tWSeyfy6r.abbEvAgUI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, 15 Apr 2021 19:11:08 -0700 Dan Williams <dan.j.williams@intel.com> =
wrote:
>
> These will be submitted to Linus directly.

Thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/utP3tWSeyfy6r.abbEvAgUI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB4+YoACgkQAVBC80lX
0GwHyggAnWZQs4EH/eiVHyYYR3lHKNybGc61BtCOltK47KoLw/Tca/IYv4jUH05v
GZuSeN4+ecOzP5xLAs8YfLsF72IIWR840Tlb4EarlCn+vpI6u0syrDdd8nTQhmBO
bR5KXak1ISBeNm8KfIHZJSPnT4nSYAwBwRroBUpgqOa2rCRy1kAcK6AIl1fUubIL
FHUtKqqsuTQ+0xGzI90zT/YUXlqyPN9Nox/PfplpZR+brjiXP/wj5GRjiRyYsqCW
9i95YMIhP+kYjsEbvDz3mmVrCWYgp89ZpSNlPOhU5tFvzwWnlfqGo9HLYgzNhd5S
WL8ZgEcoBYiVnXJ4ExbLLqJZGTCfSg==
=nNpv
-----END PGP SIGNATURE-----

--Sig_/utP3tWSeyfy6r.abbEvAgUI--
