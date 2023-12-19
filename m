Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021F3715D
	for <linux-cxl@vger.kernel.org>; Tue, 19 Dec 2023 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SvjFY3f0wz6K62n;
	Wed, 20 Dec 2023 00:44:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 780AB140F7F;
	Wed, 20 Dec 2023 00:44:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 16:44:10 +0000
Date: Tue, 19 Dec 2023 16:44:08 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Brice Goglin <brice.goglin@gmail.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
Message-ID: <20231219164408.0000790a@Huawei.com>
In-Reply-To: <500b0900-f4bb-475d-817b-6a72f18e0134@intel.com>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
	<170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
	<23a78aa8-e076-4b98-bd7c-4299aefd9895@gmail.com>
	<500b0900-f4bb-475d-817b-6a72f18e0134@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 12 Dec 2023 12:30:47 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 12/11/23 02:06, Brice Goglin wrote:
> > Le 08/12/2023 =E0 00:31, Dave Jiang a =E9crit=A0: =20
> >> Add read/write latencies and bandwidth sysfs attributes for the enable=
d CXL
> >> region. The bandwidth is the aggregated bandwidth of all devices that
> >> contributes to the CXL region. The latency is the worst latency of the
> >> device amongst all the devices that contributes to the CXL region. =20
> >=20
> >=20
> > Hello
> >=20
> > Which initiator do these bandwidths/latencies refer to? Local CPUs near=
 the root port? This should be specified in the doc. =20
>=20
> Currently I'm only storing the numbers from initiator pxm 0 to these targ=
ets in the hmat target list. I'm open to suggestions as to if a different w=
ay would be better.
Nearest node with CPUs would be better I think.

Jonathan

