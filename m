Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06723A98E;
	Tue, 22 Jul 2025 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184565; cv=none; b=jCvqXchAG5NRgSfxDen4gZiw6cdpexzZrJiWv+nh7sE8Om9Lquqiqx9OlmF8ywdu8L6ijwcckIxouhLmvtl0XkPNj2wiHgbm3yEK8pgrOEzrOTKAhvgcCI5qmxjlWL7/bFn4aw/NTrC9W+2ILLhEn13Ocz/T2b/gxn/QBUhMQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184565; c=relaxed/simple;
	bh=GA03q4he4YGapHfFDQKiYxzVzT9drEI8wAp2YAmeEZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av0oNwRHFP8gNaZy0cOLXC+m6ajqejQFgofyIrEr4arWxVWWkrKE37Xgs7gaQRukRuVfCUTzDCosQs+sFlv5yziFd/G9TZtJ9RNPMOksb5cvfzJ2ByWcfaUiGoj2Q4DUfRzX2EbWnOpS2IaW+h+EayL5DXDD9uXsW9K7VO/+aRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MWjoNI4R; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MWjoNI4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753184564; x=1784720564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GA03q4he4YGapHfFDQKiYxzVzT9drEI8wAp2YAmeEZg=;
  b=MWjoNI4RUgKCBHSoKYEQaBqXPcW6bt0WzoNWtgwts2OiEShvvh9X7iTA
   CwPz8c48yQ4cUPAtL2KRw2GmWgEnHh0whwy+TsU45piktpCccrnr0p/00
   iL+HXVSaf9dePW9Hhm3XtBHCrLG/pHxFIXS7+miWed+05lmzrnuL2Byc6
   PvJzIq6Zt2hrRxjygFc/4XbO7mxlz0tS24gzBmlFphfKXzWyh1qgfOIqz
   3s/VZZK8lxMrdvGuapr7ys+kFSozuSA71zxCYeIS1qlkpPmgN8IfpaULf
   cuFDUwq1b2Y9z4dUChJGERL/HXA8j01oZqpjRvYUiKwMowDdBaqRHwv/d
   g==;
X-CSE-ConnectionGUID: 9+s5KQ3ZTUubzZQX3uowHQ==
X-CSE-MsgGUID: hSGLPBCzSAeVJ6HQ7Xe/YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="65998021"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="65998021"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:42:43 -0700
X-CSE-ConnectionGUID: u2Rxq+g+SAWUjwPACPBklw==
X-CSE-MsgGUID: S4xwkq4MTEO84wz1D5xfOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163674521"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.65])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:42:39 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS,
 LMH, ED
Date: Tue, 22 Jul 2025 13:42:35 +0200
Message-ID: <8047110.oPnVEEUbh3@fdefranc-mobl3>
In-Reply-To: <aH2PAju1rLxIbXXk@gourry-fedora-PF4VCD3F>
References:
 <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
 <17128669.tgchFWduMW@fdefranc-mobl3>
 <aH2PAju1rLxIbXXk@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, July 21, 2025 2:51:14=E2=80=AFAM Central European Summer Time Gr=
egory Price wrote:
> On Thu, Jul 17, 2025 at 04:14:13PM +0200, Fabio M. De Francesco wrote:
> > The table above shows a real configuration copied from an x86 platform=
=20
> > where the Low Memory Hole (LMH) starts at 2GB.=20
> >=20
> > The"HDM Decoder Base/Size" refers specifically to the CXL Endpoint=20
> > Decoders HPA range Base/Size. The first row of the table describes the=
=20
> > first window (CFMWS[0]), whose HPA rage base/size is 0/2GB, and the=20
> > Endpoint Decoder that the CXL driver should match with that CFMWS,=20
> > whose HPA range base/size is 0/3GB.
>=20
> The only thing i ask is being more precise with decoder references.
>=20
> HDM Decoder can refer to any of: root, switch, hb, or endpoint decoders.
>=20
> Below you make this distinct in the explanation, but in the table it's
> simply general "HDM Decoder".  All I ask is for a bit more clarity on
> what decoder will contain what values to avoid further ambiguity.
>=20
I agree, "HDM Decoder" was ambiguous. I will relabel it to "(intermediate)=
=20
Switch and Endpoint Decoders".
>
> > The driver expects that the Endpoint Decoders HPA ranges to be containe=
d=20
> > into their corresponding Root Decoders. Furthermore, Linux fails to=20
> > attach Endpoint decoders to already constructed CXL Regions because of=
=20
> > the same size discrepancy issue.=20
> > >=20
> > > I think you need to describe what the expected behavior is for what l=
inux
> > > will produce in terms of the decoder objects given the above.
> > >
> > The expected behavior is that Linux should be able to match the Endpoin=
t=20
> > Decoder with the Root Decoder range even if the CFMWS size is smaller=20
> > than the Decoder's, as long as the latter adheres to the 256MB * interl=
eave=20
> > ways rule. Furthermore, Linux should be able to match the Endpoint deco=
ders=20
> > with already constructed CXL Regions and allow the attachment process t=
o=20
> > succeed.=20
> >=20
>=20
> You may also need to describe more than just the contents of the
> endpoint decoder.  What would the content of any intermediate decoders
> be (matching the root or matching the endpoint?).
>
I think that the output of the simulation of a hole in the cxl_test=20
mocked CXL topology, with a CFMWS HPA size of 3 * 256MiB, and Switch and=20
Endpoint Decoders HPA sizes of 4 * 256MiB can help to clarify. The Region
Interleave ways is 2.=20

In this example the CXL driver is patched and correctly deals with a=20
simulated LMH that trimmed the CFMWS[0] range size and made it not aligned
to 256MiB * IW.

[root@fedora ndctl]# cxl list -RDu -r5
[
  {
    "root decoders":[
      {
        "decoder":"decoder9.0",
        "resource":"0x3ff010000000",
        "size":"768.00 MiB (805.31 MB)",
        "interleave_ways":1,
        "max_available_extent":0,
        "volatile_capable":true,
        "qos_class":42,
        "nr_targets":1,
        "regions:decoder9.0":[
          {
            "region":"region5",
            "resource":"0x3ff010000000",
            "size":"768.00 MiB (805.31 MB)",
            "type":"ram",
            "interleave_ways":2,
            "interleave_granularity":4096,
            "decode_state":"commit"
          }
        ]
      }
    ]
  },
  {
    "port decoders":[
      {
        "decoder":"decoder10.0",
        "resource":"0x3ff010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":1,
        "region":"region5",
        "nr_targets":1
      },
      {
        "decoder":"decoder14.0",
        "resource":"0x3ff010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":2,
        "interleave_granularity":4096,
        "region":"region5",
        "nr_targets":2
      }
    ]
  },
  {
    "endpoint decoders":[
      {
        "decoder":"decoder28.0",
        "resource":"0x3ff010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":2,
        "interleave_granularity":4096,
        "region":"region5",
        "dpa_resource":"0",
        "dpa_size":"384.00 MiB (402.65 MB)",
        "mode":"ram"
      },
      {
        "decoder":"decoder23.0",
        "resource":"0x3ff010000000",
        "size":"1024.00 MiB (1073.74 MB)",
        "interleave_ways":2,
        "interleave_granularity":4096,
        "region":"region5",
        "dpa_resource":"0",
        "dpa_size":"384.00 MiB (402.65 MB)",
        "mode":"ram"
      }
    ]
  }
]

The construction of Regions and subsequent attachment of Switch and=20
Endpoint Decoders is based on matching Root Decoders and existing Regions
with Switch and Endpoint Decoders. If these objects can't be matched=20
between them, the Regions can't be constructed and/or attached with=20
the Switch and Endpoint Decoders.    =20

The CXL driver can always match Endpoint Decoders with Switch Decoders=20
because their HPA range sizes are the same regardless of LMH's. =20

But with LMH's that trim the CFMWS HPA range to smaller sizes, a=20
non-patched CXL driver can't match the Root Decoders and Regions with the=20
Switch and Endpoint decoders. Therefore, the CXL Region construction and=20
Decoders attachment can't succeed.
      }
    ]
  }
]

The construction of Regions and subsequent attachment of Switch and=20
Endpoint Decoders is based on matching Root Decoders and existing Regions
with Switch and Endpoint Decoders. If these objects can't be matched=20
between them, the Regions can't be constructed and/or attached with=20
the Switch and Endpoint Decoders.    =20

Anyway, the CXL driver can always match Endpoint Decoders with Switch
Decoders because the HPA range sizes are the same also when LMH's are =20

But with an LMH that trim the CFMWS HPA range size to a smaller size, a=20
non-patched CXL driver can't match the Root Decoders and Regions with the=20
Switch and Endpoint decoders. Therefore, the CXL Region construction and=20
Decoders attachment can't succeed.
>
> > If this explanation suffices, I will incorporate it into the next versi=
on
> > of this patch and also explain that "HDM Decoder" stands for Endpoint D=
ecoder=20
> > and that the CFMWS HPA base/size describes the System Physical Address =
(SPA)=20
> > which the CXL driver uses to make Root Decoders HPA range base/size.=20
> >=20
>=20
> This explanation is better, just need a few more bits of data and I
> think you're good to go.
>=20
Thanks,

=46abio

=46abio
>
> ~Gregory
>=20




