Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775816A940
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644005; cv=none; b=KqquBwJ3jVYmFd4qHaKw02dooja0QFzYKNQO7nIe45Ze7awmkY6wJsRAO0VgE32mFU1kJYATNs5fgrGZO1J+717vdV3GxztFzwZG+Ub4Zrw6G/Bzf8mDXfQAh5fA9Jn7ok4ax++4boRBLHInJEip+juTCHXmWdt6kzoi4g2vZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644005; c=relaxed/simple;
	bh=jNkzSjN05z5+VTe3c0lbsILDqQGRxv0DBSYmnevkBrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=nFuMpjJBl3vE+B5dL3ofCVJfalwr/XhRN8mDAtPsIO2Dk5LnsNjYKGMEeH6SzBFNbUhtZ/5puw/49qKJnNfxMZrNM0AWMwSJyD/Luu2MqcM1UvLV0X5d3o/rM2jiiBpq6PNNyJl80iwaHcNdQ2Kf3VHJVIswdtBU/LQBwKWu/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aWt9Y7Wf; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aWt9Y7Wf"
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240617165830usoutp0210d65b6161dae2499f3938667dd26f6f~Z2Src2m-E2075320753usoutp02k;
	Mon, 17 Jun 2024 16:58:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240617165830usoutp0210d65b6161dae2499f3938667dd26f6f~Z2Src2m-E2075320753usoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718643510;
	bh=nfqRosTLcCYOqqhk76YMOh3catMaDFXIiWqEhq/It/c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=aWt9Y7WfpJJohieSV3ZMImKG0ZZipjGfZhitA3Jy5EkyiImWf+d3q61bYnBO1IDMP
	 +Ufvhw02Ix/SYV6AIl8XHyvqG08c3P5r2dH38WiPnKZS56mQ+JLHvlIriCV2hD6lDP
	 25UYYtH8CApR91+G6B3xw794q42LnB5U4TT2/P1E=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240617165830uscas1p121f153dd7005137755bf0844841104ab~Z2SrXK7kl0631906319uscas1p1V;
	Mon, 17 Jun 2024 16:58:30 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 6D.90.09749.63B60766; Mon,
	17 Jun 2024 12:58:30 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f~Z2SrCqPdS1560415604uscas1p1U;
	Mon, 17 Jun 2024 16:58:30 +0000 (GMT)
X-AuditID: cbfec36f-97dff70000002615-f8-66706b36accc
Received: from SSI-EX3.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id A8.24.60920.63B60766; Mon,
	17 Jun 2024 12:58:30 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Mon, 17 Jun 2024 09:58:29 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Mon,
	17 Jun 2024 09:58:29 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Thread-Topic: [PATCH] Documentation: CXL Maturity Map
Thread-Index: AQHawNeUKXOsAWVcaUO+8dv8siuo/g==
Date: Mon, 17 Jun 2024 16:58:29 +0000
Message-ID: <ZnBrA-tUc9sWCUYR@sjvm-adma01.eng.stellus.in>
In-Reply-To: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C79F9D990BFCFD408BC8D19DD7B2C62A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djXc7pm2QVpBhvPaVlMn3qB0eLEzUY2
	i1ULr7FZnJ91isWBxaPlyFtWj8V7XjJ5fN4kF8AcxWWTkpqTWZZapG+XwJXROWUPS8F054pT
	278yNTB2mXUxcnJICJhI/Lr0ignEFhJYySjR8US8i5ELyG5lkth6ei4jTNHK/jPMEIk1jBLT
	z+yCcj4xSrQ8usMK4SxjlLjWeIMZpIVNwEDi9/GNYLaIgLbExDkHwTqYBVYzSlzq3gXUwcEh
	DDR389l0EFNEwFTiwXcTiHI9ie/b/7CD2CwCqhLt55czg5TwClhKLN1nChLmFAiTeP0MooRR
	QEzi+6k1YB8wC4hL3HoynwniaEGJRbP3MEPYYhL/dj1kg7AVJe5/f8kOUa8jsWD3JzYI205i
	7ppFUHFtiWULX4P18gLNOTnzCQtEr6TEwRU3WEA+kRDYwSGx5/wVqGUuEj8PwCyTlrh6fSqU
	nS+xq+0KlF0hcfV1N9QR1hIL/6xnmsCoMgvJ3bOQ3DQLyU2zkNw0C8lNCxhZVzGKlxYX56an
	FhvlpZbrFSfmFpfmpesl5+duYgSmmtP/DufvYLx+66PeIUYmDsZDjBIczEoivE7T8tKEeFMS
	K6tSi/Lji0pzUosPMUpzsCiJ8xrankwWEkhPLEnNTk0tSC2CyTJxcEo1MOnvbNkn+O/am3UJ
	+a6HogU1J7Zo85rHLnlufVVV8pYww89o4cuuGl/1H/h3LZ4VYTFHTevWm4X1n6/vn3rr779j
	dSvnb3n0LeW/xpzVX1gXOS2fZMJnVJs02dD3t2h7T4vymb2ymrq3NS9fvcrHd3BKiFlUVBZ/
	muqVWxEWN8X3TAkR9iyPXbE6bEvwxoOVbyqeKFk9E5826/MH1ct8Z5p+hPY8Oqv844jnHU7d
	pG/m0nZ+f1n/7rNvMhR6Fx4sw3pZxbb19ALFW9Yzbh7+4LxcNPnIqwLh+8mJbK6q81z3O4oa
	+Z4/0CGedtA5bpG4xX6hV9rOT1JPb5W8fqes5rCSxJKsws09B+dyXu1zm6bEUpyRaKjFXFSc
	CAAAfhHipAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWS2cDspGuWXZBmsHSzmMX0qRcYLU7cbGSz
	WLXwGpvF+VmnWBxYPFqOvGX1WLznJZPH501yAcxRXDYpqTmZZalF+nYJXBmdU/awFEx3rji1
	/StTA2OXWRcjJ4eEgInEyv4zzF2MXBxCAqsYJTa9amaEcD4xSpxq+cYO4SxjlHjd844JpIVN
	wEDi9/GNzCC2iIC2xMQ5B8HamQVWM0pc6t7F2sXIwSEMNHfz2XQQU0TAVOLBdxOIcj2J79v/
	sIPYLAKqEu3nlzODlPAKWEos3WcKYgoJhEpc7Y4CqeAUCJN4/QyimlFATOL7qTVgBzALiEvc
	ejKfCeJ+AYkle84zQ9iiEi8f/2OFsBUl7n9/yQ5RryOxYPcnNgjbTmLumkVQcW2JZQtfg/Xy
	CghKnJz5hAWiV1Li4IobLBMYJWYhWTcLyahZSEbNQjJqFpJRCxhZVzGKlxYX56ZXFBvmpZbr
	FSfmFpfmpesl5+duYgRG6el/hyN3MB699VHvECMTB+MhRgkOZiURXqdpeWlCvCmJlVWpRfnx
	RaU5qcWHGKU5WJTEee8+0EgVEkhPLEnNTk0tSC2CyTJxcEo1MC0qPBNQwr6n2O/6pYk7uhj5
	3qyrUqt4FqCaz95u/XNW9yvL9Z+Fin/Jr2dfvLJl16rDCelL3GLOmO9rNthdm7vH+Yms2b9C
	8fbIk1xvvQ/5Ni2QKN6qxnnfU5l9st4BU556NX0XfS11afOd85StQ58lqvLNNuFRfnGiTTnn
	jPWpG3/T3t66mJ6498LUAjMWkeCEuKI2ydUscxQaclWqtzAYTZ2Stvjzs5B7cvwT3HYc/Hfm
	9MYLPS2qXi8/r1lxLH3mxrfcCptavjx5Ylaa2XWr//CBn7WTOBkS90Wr/nh98/ivO5qzzCbm
	Me9J54x4PNvyl+eCb22xvm86V5t+Y33c+NH5k+O3vFV/IxfZ7VNiKc5INNRiLipOBAD0jjQk
	QQMAAA==
X-CMS-MailID: 20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f
CMS-TYPE: 301P
X-CMS-RootMailID: 20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
	<CGME20240617165830uscas1p12e867fc6ad52fa7cfa32955f3150dd6f@uscas1p1.samsung.com>

On Fri, May 24, 2024 at 05:53:49PM -0700, Dan Williams wrote:
> Provide a survey of the work-in-progress maturity (implementation
> status) of various aspects of the CXL subsystem.
>=20
> Clarify that in addition to ongoing upkeep relative to specification
> updates, there are some long running themes in the driver that respond
> to the discovery of new corner cases (bugs) and new use cases (feature
> extensions).
>=20
> The primary audience is distribution maintainers, but it also serves as
> a guide for kernel developers to understand what aspects of the CXL
> subsystem need more help. It is a landing page to document ongoing
> progress, and a guide to discern exposure to work-in-progress features.
>=20

Thanks for putting this together Dan and thanks Jonathan for putting this
thread in my inbox.

> Help wanted / welcome to expand on the "Details" section.
>=20
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |    2=20
>  Documentation/driver-api/cxl/maturity-map.rst |  173 +++++++++++++++++++=
++++++
>  MAINTAINERS                                   |    1=20
>  3 files changed, 176 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/maturity-map.rst
>=20
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/drive=
r-api/cxl/index.rst
> index 036e49553542..12b82725d322 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -9,4 +9,6 @@ Compute Express Link
> =20
>     memory-devices
> =20
> +   maturity-map
> +
>  .. only::  subproject and html
> diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentatio=
n/driver-api/cxl/maturity-map.rst
> new file mode 100644
> index 000000000000..9c5bff6484dd
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/maturity-map.rst
> @@ -0,0 +1,173 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Compute Express Link Subsystem Maturity Map
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The Linux CXL subsystem tracks the dynamic `CXL specification
> +<https://computeexpresslink.org/cxl-specification-landing-page>`_ that
> +continues to respond to new use cases with new features, capability
> +updates and fixes. At any given point some aspects of the subsystem are
> +more mature than others. While the periodic pull requests summarize the
> +`work being incorporated each merge window
> +<https://lore.kernel.org/linux-cxl/?q=3Ds%3APULL+s%3ACXL+tc%3Atorvalds+N=
OT+s%3ARe>`_,
> +those do not always convey progress relative to a starting point and a
> +future end goal.
> +
> +What follows is a coarse breakdown of the subsystem's major
> +responsibilities along with a maturity score. The expectation is that
> +the change-history of this document provides an overview summary of the
> +subsystem maturation over time.
> +
> +The maturity scores are:
> +
> +- [3] Mature: Work in this area is complete and no changes on the horizo=
n.
> +  Note that this score can regress from one kernel release to the next
> +  based on new test results or end user reports.
> +
> +- [2] Stabilizing: Major functionality operational, common cases are
> +  mature, but known corner cases are still a work in progress.
> +
> +- [1] Initial: Capability that has exited the Proof of Concept phase, bu=
t
> +  may still have significant gaps to close and fixes to apply as real
> +  world testing occurs.
> +
> +- [0] Known gap: Feature is on a medium to long term horizon to
> +  implement.  If the specification has a feature that does even have a '=
0'

s/that does even have/that does not even have

> +  score in this document, there is a good chance that no one in the
> +  linux-cxl@vger.kernel.org community has started to look at it.
> +
> +- X: Out of scope for kernel enabling, or kernel enabling not required
> +
> +Feature and Capabilities
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Enumeration / Provisioning
> +--------------------------
> +All of the fundamental enumeration an object model of the subsystem is
> +in place, but there are several corner cases that are pending closure.
> +
> +
> +* [2] CXL Window Enumeration
> +
> +  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> +  * [0] Low Memory-hole
> +  * [0] Hetero-interleave
> +
> +* [2] Switch Enumeration
> +
> +  * [0] CXL register enumeration link-up dependency
> +
> +* [2] HDM Decoder Configuration
> +
> +  * [0] Decoder target and granularity constraints
> +
> +2 Performance enumeration
> +
> +  * [3] Endpoint CDAT
> +  * [3] Switch CDAT
> +  * [1] CDAT to Core-mm integration
> +  * [1] Shared link
> +
> +* [2] Hotplug
> +  (see CXL Window Enumeration)
> +
> +  * [0] Handle Soft Reserved conflicts
> +
> +* [0] :ref:`RCH link status <rch-link-status>`
> +
> +RAS
> +---
> +In many ways CXL can be seen as a standardization of what would normally
> +be handled by custom EDAC drivers. The open development here is
> +mainly caused by the enumeration corner cases above.
> +
> +* [3] Component events (OS)
> +* [2] Component events (FFM)
> +* [1] Endpoint protocol errors (OS)
> +* [1] Endpoint protocol errors (FFM)
> +* [0] Switch protocol errors (OS)
> +* [1] Switch protocol errors (FFM)
> +* [2] DPA->HPA Address translation
> +
> +    * [1] XOR Interleave translation
> +      (see CXL Window Enumeration)
> +
> +* [1] Memory Failure coordination
> +* [0] Scrub control
> +* [2] ACPI error injection EINJ
> +
> +  * [0] EINJ v2
> +  * [X] Compliance DOE
> +
> +* [2] Native error injection
> +* [3] RCH error handling
> +* [1] VH error handling
> +
> +Mailbox commands
> +----------------
> +
> +* [3] Firmware update
> +* [3] Health / Alerts
> +* [1] :ref:`Background commands <background-commands>`
> +* [3] Santization

s/Santization/Sanitation

> +* [3] Security commands
> +* [3] RAW Command Debug Passthrough
> +* [0] CEL-only-validtion Passthrough
> +* [0] Switch CCI
> +* [3] Timestamp
> +* [1] PMU
> +* [1] PMEM labels
> +* [0] PMEM GPF / Dirty Shutdown
> +
> +Security
> +--------
> +
> +* [X] CXL Trusted Execution Environment Security Protocol (TSP)
> +* [X] CXL IDE (subsumed by TSP)
> +
> +Multi-host memory
> +-----------------
> +
> +* [0] Dynamic Capacity Device Support
> +* [0] Sharing
> +
> +Accelerator
> +-----------
> +
> +* [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
> +* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
> +* [0] CXL.cache 68b (CXL 2.0)
> +* [0] CXL.cache 256b Cache IDs (CXL 3.0)
> +
> +User Flow Support
> +-----------------
> +
> +* [0] HPA->DPA Address translation (need xormaps export solution)
> +
> +Details
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +.. _extended-linear:
> +
> +* **Extended-linear memory-side cache**: An HMAT proposal to enumerate t=
he presence of a
> +  memory-side cache where the cache capacity extends the SRAT address
> +  range capacity. `See the ECN
> +  <https://lore.kernel.org/linux-cxl/6650e4f835a0e_195e294a8@dwillia2-mo=
bl3.amr.corp.intel.com.notmuch/>`_
> +  for more details:
> +
> +.. _rch-link-status:
> +
> +* **RCH Link Status**: RCH (Restricted CXL Host) topologies, end up
> +  hiding some standard registers like PCIe Link Status / Capabilities in
> +  the CXL RCRB (Root Complex Register Block).
> +
> +.. _background-commands:
> +
> +* **Background commands**: The CXL background command mechanism is
> +  awkward as the single slot is monopolized potentially indefinitely by
> +  various commands. A `cancel on conflict
> +  <http://lore.kernel.org/r/66035c2e8ba17_770232948b@dwillia2-xfh.jf.int=
el.com.notmuch>`_
> +  facility is needed to make sure the kernel can ensure forward progress
> +  of priority commands.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e533476081ba..d092b2ae5f25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5331,6 +5331,7 @@ M:	Ira Weiny <ira.weiny@intel.com>
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/driver-api/cxl
>  F:	drivers/cxl/
>  F:	include/linux/einj-cxl.h
>  F:	include/linux/cxl-event.h
> =
