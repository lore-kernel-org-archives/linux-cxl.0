Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C839C433B4
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408BF6117A
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Apr 2021 02:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhDPCUq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Apr 2021 22:20:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235017AbhDPCUp (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 15 Apr 2021 22:20:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FM0Kx0YMfz9sWK;
        Fri, 16 Apr 2021 12:20:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1618539621;
        bh=YUMqn14e9rlV1dzxlwtz8AFj/8kq6vAlU7cSNi9Bed8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HGKdQottk73i4Z2RnzT7WWDfpYm5fWIC4Ap28HaOrEA7ARtniW1kbLCKVtsTkfHXg
         jb3xl8KF1Zd2j2dBkD2LIQots+bAuMHH98Y7uOvgNmI45gmOj3wOoXL2CJX9XjbkJW
         X1NwRbTZ/76oiUMdBc1mrjeVacoyIKPsQVrPRDsmZDKwyH9RmYf/ceq9MPyauQbMUz
         ZqS92syuUHupikfw5d8+XzNq+eyr8+hTff2SgoAbz267T1e5PKpSr5Uxizb5XybZ8N
         oFCCCWPzBtwboC3dCYTFwiPZMKsEAFyTjvHNOumwA+jyyg/lYVdEAywLPX8H88kE8/
         oguB0/Y9Luyhg==
Date:   Fri, 16 Apr 2021 12:20:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: CXL Trees for linux-next
Message-ID: <20210416122020.185eae1c@canb.auug.org.au>
In-Reply-To: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
References: <CAPcyv4gseedV78W72ERtdGozW_V3aTpPDw5-Py3X4HWRFYRbSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+6_DGREZtzPiaRUj=PbKoNH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

--Sig_/+6_DGREZtzPiaRUj=PbKoNH
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

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/+6_DGREZtzPiaRUj=PbKoNH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB49GQACgkQAVBC80lX
0Gwhfgf/UNp4MvhqUWHpGwk7xRUSzD93HjhHMNlQhtjb1XjkmiR8Iu+6DA8OxlaA
hGEdp/T8gCOFrY9yuCpvcMRim75x/aakjJbeL2yD2ug5I2GypGuZa203m31hdDUP
S2SBKJxSyHvDOG4W/LRsiIvl2dEQrT4+QJ2TVrvUhb929+hLfGQdaYRiU5KwdU+8
5H1LOywEfvnH8AVT+yZaPFq0BfGj+n6JHFNR1GqbTX8jqft+X39HfVn4JLS1wL1L
vuV3BHpl7nqVAv4URBBbbvWtU6IXWFv+6wuVUAZX3jw70QGmRvUh9H5hfJ9l90Ec
jFHyd1nL6BcNI+SCyunc4BgS9a0Xrw==
=zAYb
-----END PGP SIGNATURE-----

--Sig_/+6_DGREZtzPiaRUj=PbKoNH--
