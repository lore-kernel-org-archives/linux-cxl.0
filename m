Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB871E868;
	Tue,  3 Dec 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250219; cv=none; b=Zpsre+aY7aaVTHn4asxvQWk6u5K8iqiF96PZWs6SFQOpmdn0JSwmWXHCQu6RYNYM7FjMnxrmLj2n06zdu8wR4+Ez/L5hGyVeODxDs4rgtq5bssqLksbtRe9yRYdP1rnepm2JzNqC96x+BZwcBqELwJ3UMRQHZHdQrPQFlC0QVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250219; c=relaxed/simple;
	bh=QzF6Byl04Y7zw2pdSphTHXzXqOVNn8t17tzJb0f//jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taqxklzCIV06OSjNQW/4VfDTNUu22A/XjlRynk2wJdOoXwXObGZZrv8c8+r3SduUustP3IBV6vMWeid9b3z2LHofGyyeRkiNgJpYoIW+c2xJa8KeHWEUSFZx8kTHP3tqSatYEwslO3HVmCJXvrhghgtAVc9jpd3rOxhNR0cWmSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUdF73ZA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUdF73ZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733250217; x=1764786217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzF6Byl04Y7zw2pdSphTHXzXqOVNn8t17tzJb0f//jQ=;
  b=OUdF73ZAREgJEyQxvfxFn0gp7GS/rkn/X8nofWNsKS4cRWqJIjGbFzn5
   6l5hCIgG93CCkR3HmAoHQYNYwsLkG25JgS8g4IB5+rQwKc8iAJM0NJcKK
   ebCPRmZFy4pEMlWNnvHt0va4PUxoc/usWZyB2E6E8E86daWm1CxcML9Cf
   GqH7tp8gCcTL7lZ9cjyVtuuyCmQBD1LSf6h7RjEc9WPla8uxp2wYTuJBy
   dmAzXRhnY0/jt2fgx+A39+DVXxLcg6qshbEWfRLVN4se4FdJ+1FQPps2b
   EB80sxUUO8ZnSFBIMeI/SpRbNIQnsYmJll/8ekrP5AWNKe8TPCX1GN+IE
   Q==;
X-CSE-ConnectionGUID: E0w0iJ9pR8ynEduFoA3HQw==
X-CSE-MsgGUID: rcrXFHodRYKbtXZbSPH8uQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33615098"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33615098"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 10:23:33 -0800
X-CSE-ConnectionGUID: +rS42ysjRSqfRI1i6r6ABA==
X-CSE-MsgGUID: GUomxcKuQGaavVLwWWR/FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="130969713"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.245.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 10:23:30 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Alison Schofield <alison.schofield@intel.com>, linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, linux-kernel@vger.kernel.org,
 Li Ming <ming4.li@outlook.com>
Subject:
 Re: [PATCH 0/3] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Tue, 03 Dec 2024 19:23:28 +0100
Message-ID: <1875878.sHLxoZxqIA@fdefranc-mobl3>
In-Reply-To: <Z0Tzif55CcHuujJ-@aschofie-mobl2.lan>
References:
 <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <Z0Tzif55CcHuujJ-@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, November 25, 2024 11:00:41=E2=80=AFPM GMT+1 Alison Schofield wro=
te:
> On Fri, Nov 22, 2024 at 04:51:51PM +0100, Fabio M. De Francesco wrote:
> > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Ho=
st
> > Physical Address (HPA) windows that are associated with each CXL Host
> > Bridge. Each window represents a contiguous HPA that may be interleaved
> > with one or more targets (CXL v3.1 - 9.18.1.3).
> >=20
> > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > memory to which systems cannot send transactions. On those systems, BIOS
> > publishes CFMWS which communicate the active System Physical Address (S=
PA)
> > ranges that map to a subset of the Host Physical Address (HPA) ranges. =
The
> > SPA range trims out the hole, and capacity in the endpoint is lost with=
 no
> > SPA to map to CXL HPA in that hole.
> >=20
> > In the early stages of CXL Regions construction and attach on platforms
> > with Low Memory Holes, the driver fails and returns an error because it
> > expects that the CXL Endpoint Decoder range is a subset of the Root
> > Decoder's.
> >=20
> > Then detect SPA/HPA misalignment and allow CXL Regions construction and=
=20
> > attach if and only if the misalignment is due to x86 Low Memory Holes.
> >=20
>=20
> Hi Fabio,
>=20
> I took this for a test drive in cxl-test - thanks for that patch!
>=20
> Here's a couple of observations on what users will see. Just stirring
> the pot here, not knowing if there is, or even needs to be an explanation
> to userspace about LMH.
>=20
> 1) Users will see that the endpoint decoders intend to map more than the
> root decoder. Users may question their trimmed region size.
>=20
> 2) At least in this example, I don't think users can re-create this
> region in place, ie via hotplug.  Once this region is destroyed, we
> default to creating a smaller, aligned region, in its place.
>=20
Hi Alison,

Thank you for your valuable comments and suggestions on my series. I will=20
take them into account for the next version (v2).

I also appreciate your observations regarding the consistency between the t=
wo=20
methods of creating regions. I agree that we should aim for more uniformity=
 in
this area and we will consider that in the future but we will only create s=
pec=20
standard aligned  user created regions now.

Thanks again for your insights.

=46abio
>
> cxl-cli output is appended showing the auto created region, it's decoders,
> and then the creation of a user requested region, not exactly in its
> place.
>=20
>=20
> Upon load of cxl-test:
>=20
> # cxl list -r region0 --decoders -u
> [
>   {
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":"0xf010000000",
>         "size":"768.00 MiB (805.31 MB)",
>         "interleave_ways":1,
>         "max_available_extent":0,
>         "volatile_capable":true,
>         "qos_class":42,
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "port decoders":[
>       {
>         "decoder":"decoder1.0",
>         "resource":"0xf010000000",
>         "size":"1024.00 MiB (1073.74 MB)",
>         "interleave_ways":1,
>         "region":"region0",
>         "nr_targets":1
>       },
>       {
>         "decoder":"decoder6.0",
>         "resource":"0xf010000000",
>         "size":"1024.00 MiB (1073.74 MB)",
>         "interleave_ways":2,
>         "interleave_granularity":4096,
>         "region":"region0",
>         "nr_targets":2
>       }
>     ]
>   },
>   {
>     "endpoint decoders":[
>       {
>         "decoder":"decoder10.0",
>         "resource":"0xf010000000",
>         "size":"1024.00 MiB (1073.74 MB)",
>         "interleave_ways":2,
>         "interleave_granularity":4096,
>         "region":"region0",
>         "dpa_resource":"0",
>         "dpa_size":"512.00 MiB (536.87 MB)",
>         "mode":"ram"
>       },
>       {
>         "decoder":"decoder13.0",
>         "resource":"0xf010000000",
>         "size":"1024.00 MiB (1073.74 MB)",
>         "interleave_ways":2,
>         "interleave_granularity":4096,
>         "region":"region0",
>         "dpa_resource":"0",
>         "dpa_size":"512.00 MiB (536.87 MB)",
>         "mode":"ram"
>       }
>     ]
>   }
> ]
>=20
> After destroying the auto region, root decoder show the 768MiB available:
>=20
> # cxl list -d decoder0.0 -u
> {
>   "decoder":"decoder0.0",
>   "resource":"0xf010000000",
>   "size":"768.00 MiB (805.31 MB)",
>   "interleave_ways":1,
>   "max_available_extent":"768.00 MiB (805.31 MB)",
>   "volatile_capable":true,
>   "qos_class":42,
>   "nr_targets":1
> }
>=20
>=20
> # cxl create-region -d decoder0.0 -m mem5 mem4
> {
>   "region":"region0",
>   "resource":"0xf010000000",
>   "size":"512.00 MiB (536.87 MB)",
>   "type":"ram",
>   "interleave_ways":2,
>   "interleave_granularity":256,
>   "decode_state":"commit",
>=20
> snip
>=20
> # cxl list -r region0 --decoders -u
> [
>   {
>     "root decoders":[
>       {
>         "decoder":"decoder0.0",
>         "resource":"0xf010000000",
>         "size":"768.00 MiB (805.31 MB)",
>         "interleave_ways":1,
>         "max_available_extent":"256.00 MiB (268.44 MB)",
>         "volatile_capable":true,
>         "qos_class":42,
>         "nr_targets":1
>       }
>     ]
>   },
>   {
>     "port decoders":[
>       {
>         "decoder":"decoder1.0",
>         "resource":"0xf010000000",
>         "size":"512.00 MiB (536.87 MB)",
>         "interleave_ways":1,
>         "region":"region0",
>         "nr_targets":1
>       },
>       {
>         "decoder":"decoder6.0",
>         "resource":"0xf010000000",
>         "size":"512.00 MiB (536.87 MB)",
>         "interleave_ways":2,
>         "interleave_granularity":256,
>         "region":"region0",
>         "nr_targets":2
>       }
>     ]
>   },
>   {
>     "endpoint decoders":[
>       {
>         "decoder":"decoder10.0",
>         "resource":"0xf010000000",
>         "size":"512.00 MiB (536.87 MB)",
>         "interleave_ways":2,
>         "interleave_granularity":256,
>         "region":"region0",
>         "dpa_resource":"0",
>         "dpa_size":"256.00 MiB (268.44 MB)",
>         "mode":"ram"
>       },
>       {
>         "decoder":"decoder13.0",
>         "resource":"0xf010000000",
>         "size":"512.00 MiB (536.87 MB)",
>         "interleave_ways":2,
>         "interleave_granularity":256,
>         "region":"region0",
>         "dpa_resource":"0",
>         "dpa_size":"256.00 MiB (268.44 MB)",
>         "mode":"ram"
>       }
>     ]
>   }
> ]
>=20
>=20




