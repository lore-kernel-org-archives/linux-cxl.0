Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04293C433ED
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92AC61166
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbhDPCJh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:09:37 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44987 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhDPCJf (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 15 Apr 2021 22:09:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FM051594Jz9sWQ;
        Fri, 16 Apr 2021 12:09:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1618538949;
        bh=plBSy/aCn9Br3iyOhupmMwv9+fP+G0XZ0ThaItbhNGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wkhy/s0eUcLvy/B47wdWx5fYre85CPbta7/fe8+cKMmJJrH9X0e09kgmPK7uO16Dt
         PuX9LD7vb/iRfuFoyDbMSUNVDUdkMDEwu16H8hqr6agc3XqD5b/G/xNEIIfVYSZvKv
         sEruw6Im8Qg/EHdcsGHZDEFi/Zs2eoqsgSjhFWGncQnADnfmHehrEliVT5W7/G8bLv
         CiJd5A+E+EYOmBYweWgF0n49tVPBE7SC3WEQJmZWWX2flOxi2xAllJ3PQgqvD3QPf5
         tYqpS6r1UV08wocU20I/mJwsNvmpG9kzsOEJtVuz56crT5aLHwYtgJz44niJgvHMQT
         /EExjC9bfD8qQ==
Date:   Fri, 16 Apr 2021 12:09:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: CXL Trees for linux-next
Message-ID: <20210416120905.19211c7c@canb.auug.org.au>
In-Reply-To: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
References: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SBQpPuDHOm4WD_LqC0f9jdd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

--Sig_/SBQpPuDHOm4WD_LqC0f9jdd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, 15 Apr 2021 18:52:53 -0700 Dan Williams <dan.j.williams@intel.com> =
wrote:
>
> CXL development has established a cxl.git repo on git.kernel.org. Please =
add:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git fixes
>=20
> ...for fixes targeting the current rc cycle, and:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
>=20
> ...for new development targeting the merge window.

Will this be merged directly to Linus, or via another tree?

--=20
Cheers,
Stephen Rothwell

--Sig_/SBQpPuDHOm4WD_LqC0f9jdd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB48cEACgkQAVBC80lX
0GwngAf/Wdj2sGqVxHk1//sOxxlZV1R8HqMICKPnPbsbh1XewHiLDJGakVYa2FFS
CDYH89rwMch/QeuX8ZGiZ2Qn7wcOdrTuEFXH3pjEG5lR4a1kX8I6MJnueANP1hAe
zbivYveKJAClgQLbTdsn9ssjA+/Rihr3EcV6/q8HBbwbNWS1fyNcwVco9D3stoAn
tLy3Uq32XznBBHJHG2kg0++e99WMHqiB2+HjMxDnkk9u19HcuompGIlUmr1TGBgf
fd/KVTmxGgpqqfnSdZ+goKoiHR89jNSrjZIRbm7RfLa8mvmBFGaaBTwYjJOkrhgX
1av+MkFBLj3eh1dUPb00BK0WDel24w==
=aDyX
-----END PGP SIGNATURE-----

--Sig_/SBQpPuDHOm4WD_LqC0f9jdd--
