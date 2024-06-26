Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F45A179957;
	Wed, 26 Jun 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397923; cv=none; b=EyzhTcqQG0JkhZXgTH1ecmEc4w3dwNZFPsdE+q61jOhKmRBGuu7Ao+U+/UhdfbVMY4CBt+B4US2z0F3dIBNTR1S56veYVTH+0lg/OJMPpaqEzjhT+Nxwi20JCmfyY94/Hf2kIlJUJwyRAVPt3O6o4Zhy5suBu+Ycvcxi9dPbopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397923; c=relaxed/simple;
	bh=vpptSYzNXJVzy4Ii/5nsfkQ0IldCISPnS6J6SkA+I54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnQi2fFjoAyKZaO9C7KA9Ri5SxpE3UxpWMjYOj+GC2EIzmn7qdA8J3t0JEk2R2WL+5DAeYPnxr0wVsQDYS+3uYxrz3Ef74UwWnAPpvElt5sxAsPmJTP4Ubo6rn/hY9Uy89WxutfhxIQwaEWh29KJkseEvnbZFWkwZszB07yLqu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6HJIGsk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6HJIGsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719397922; x=1750933922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vpptSYzNXJVzy4Ii/5nsfkQ0IldCISPnS6J6SkA+I54=;
  b=R6HJIGsk5tb8AZxNpgvJmOPsWKPuGri8XPyKdKQhrHF+HZJ6W1nZWqaP
   qE4AuDe6TrUkjvd+liDDzv8Jy/tl58OJH7EHM7nHR1JsWUaa9/teIR/8t
   NxkBlJkqUyoJ6KYfdba0zFI44rxbGdNwXqy71mCEIk5xL9FHN7ezWZ4Wl
   5O7rdwIteslgWTJtY0Oltdu202RRHzMkCi3f1xtZE7xWWq5tYPODJhbnq
   2iyl1hLt7cNU6Ru+Y0opGuvA1vRX+difBB4lkLqpcxTeVHgrNN40ttWNA
   mZtfvqI+uDIvj8/2ECFLnVUZ73K1j5TpNw2oRSMh4mEYzwDChF6JQm7++
   g==;
X-CSE-ConnectionGUID: RgjabHvaQGWykFYGMPiB/A==
X-CSE-MsgGUID: 6mUA69OERGWPE+5IPASVpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16608282"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16608282"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:32:02 -0700
X-CSE-ConnectionGUID: U/2pJQCPRJC4ITskhWN2LQ==
X-CSE-MsgGUID: 4XtqxsDcS3CZf5M+vywxFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="75162876"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 03:31:58 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/acpi: Warn on unsupported platform config detection
Date: Wed, 26 Jun 2024 12:31:54 +0200
Message-ID: <5714543.ZASKD2KPVS@fdefranc-mobl3>
In-Reply-To: <667b649a3a2d_5639294a3@dwillia2-xfh.jf.intel.com.notmuch>
References:
 <20240619125949.167936-1-fabio.m.de.francesco@linux.intel.com>
 <ZntcWQ7pMtOpuT4a@aschofie-mobl2>
 <667b649a3a2d_5639294a3@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, June 26, 2024 2:45:14=E2=80=AFAM GMT+2 Dan Williams wrote:
> Alison Schofield wrote:
> > On Wed, Jun 19, 2024 at 02:59:41PM +0200, Fabio M. De Francesco wrote:
> >=20
> > Fabio,
> >=20
> > cxl/acpi does a lot of platform config work. "...unsupported platform
> > config detection" gives no hint that this is about CHBS's or an eRCD.
> > Please offer something more specific. Thanks.
>=20
> The message specifies "mixed Virtual Host and Restricted CXL Host
> hierarchy" as the conflict. The relationship between RCH and eRCDs is an
> exercise for the reader, and CHBS is an ACPI detail that really should
> not be emitted in an error message. So I am struggling to imagine what a
> more specific error message would be without paragraphs of backstory.
>=20
> All that is needed here is just enough words for when someone posts a
> problem to the list that someone savvy can go "ah, you fell into this
> specification hole where CXL 2.0 root port registers are difficult to
> associate with an RCH config, thanks for the report now we know that
> Linux needs to worry about this case".
>=20
I think that Alison raised a good point.

If you have nothing against it, I'll change the subject line to: "cxl/acpi:=
=20
Warn on mixed VH and eRCH hierarchies"

How about that change?

=46abio



