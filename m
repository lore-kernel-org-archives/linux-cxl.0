Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5D326D77;
	Mon,  1 Sep 2025 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729598; cv=none; b=ES+Y+ct9YBRf1Q9JFrvRTWc5Px8ZTykdpX5aQP3X0GG5DxOfmnAgu97x2hJtU/fG67rwCtIPmJlKm547Z2sYEzNtbV8OoQ/DbVdYezsvCFoMoHlf7qyULe71lXsSCLvcVHs9eozHPJq7YSnDRyNfN3vZxXyIVuMcVWeJ2wiyOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729598; c=relaxed/simple;
	bh=QYvjdEo8hDeG/svNSeSFatsIp0UAHlu3ckbDaTUk3E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YR6C4ZK0OpP+gXp0OexW18TiB55km9EreL/ZkZdSemjnQpKzxh9EZTf5f8GHdpMGre/ZYpYFzfDyxZ5hbMvABDidOt0Y5OS6eFq87Zuu1cO7EkruOMPiAk8g6gNFoNcG+P8SfzvmBL5YIUCrhr2WSUzfsXAvpbU5uUC+Hpb93Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdYkh1nG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdYkh1nG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756729597; x=1788265597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYvjdEo8hDeG/svNSeSFatsIp0UAHlu3ckbDaTUk3E8=;
  b=jdYkh1nGHuuPWoUWCmbP8dPJ8AfvhhtXZvKxg28h6y6oRHM5TdLlpdru
   +KM9XnSktrk4eOUZzxBQsQDFmY9+3ZubUEfwbzf8XIzBf6N/m8B2yiX/U
   02G4Gg0VuPYhc9eKMXGN9hAC5i7izZZqc1jR0n1O1AF5RW3e7uHUzxb6U
   t2svgtDwtbqEI9ZZ0DSTvCG7B6wVh7C2hkZdg+gw/kRy9k4jMNbD4pk9b
   uysP3jjP/Mj+H9ZWKskKR2nSP3adzDkz1Be/j0bpU4/LJDxqK6eESbjB8
   /Y+1Z5PaqMyjGMQEkV6RXbSLnKhIBqa7BkMRnUI9dNli5BA72csxTiX4d
   w==;
X-CSE-ConnectionGUID: IGUxm2kiTTelov4VSHO7tg==
X-CSE-MsgGUID: b7HMsgMgRVOxoWb5qY1fMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="69252299"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="69252299"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:26:36 -0700
X-CSE-ConnectionGUID: Uk/nFCx8TjGNJhhPtXJhOQ==
X-CSE-MsgGUID: vFf83oKEQ7axVEkYuNt30A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="171177078"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.162])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 05:26:32 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 ALOK TIWARI <alok.a.tiwari@oracle.com>, Randy Dunlap <rdunlap@infradead.org>
Subject:
 Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts between
 CFMWS, LMH, Decoders
Date: Mon, 01 Sep 2025 14:26:27 +0200
Message-ID: <6403027.OV4Wx5bFTl@fdefranc-mobl3>
In-Reply-To: <aK9pUhETnNgs-7UG@gourry-fedora-PF4VCD3F>
References:
 <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
 <aK9pUhETnNgs-7UG@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, August 27, 2025 10:23:46=E2=80=AFPM Central European Summer T=
ime Gregory Price wrote:
> On Wed, Aug 20, 2025 at 05:06:39PM +0200, Fabio M. De Francesco wrote:
> > +
> > +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> > +starting at 2 GB:
> > +
> > +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size=
 | Ways | Granularity
> > +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB      =
 |  12  |    256
> > +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB      =
 |  12  |    256
> > +
>=20
> This may be a dumb question, but... how is validation supposed to work?
>=20
> Like in theory according to the above something like the following would
> also be valid:
>=20
> Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size
>   0    |   4 GB     |   380 GB   |      2 GB        |     382 GB     =20
>=20
I'm sorry, it seems that a mistake with copy/pasting I made has led you to=
=20
hypothesize a case that is out of scope of this document.

A case like the one you described will still lead the CXL driver to fail.

Please refer to my reply to Robert and to an old email from Dan.[1][2]

Thanks,

=46abio

[1] https://lore.kernel.org/linux-cxl/4179950.vuYhMxLoTh@fdefranc-mobl3/
[2] https://lore.kernel.org/linux-cxl/67ec4d61c3fd6_288d2947b@dwillia2-xfh.=
jf.intel.com.notmuch/
>
> (ignoring ways/granularity, i didn't adjust those).
>=20
> The entirety of the CFMWS would be contained within the HDM decoder, but
> with carve-outs on either end.  This would be "allowed" according to the
> logic here.
>=20
> This would effectively allow all HDM decoder base/size values to be valid
> as long as one CFMWS is contained entirely within it.
>=20
> As a result, wouldn't it then also be valid to have an HDM Decoder cover
> more than one CFMWS range (two full CFMWS described by a single HDM
> decoder).
>=20
> That seems like it could cause issues.
>=20
> ~Gregory
>=20
>=20




