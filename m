Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E114372A
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503215; cv=none; b=QL6ZbdJq2mLt9zaLUz1idyiqjNctHrltGR/LDdmfiSbx1eQulGAMJAJF9JgZKmmhGl7BpKxTvqDSBzf1TIFuGpysGhFOJIsiBM8ZpbqAs3PLIuz0H815uUx0IOjcvVUNOCWnLg66XftSS2xlDRxre7T8/N4joNZzYBmnJy5OTNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503215; c=relaxed/simple;
	bh=VcqEdR0CHhDaD1YIaGXwoXTpu0L5sRJ71BT0ea0CktU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cug3RM/AVAQzipt10HoJS8LUVqKDanWzxjQtuhHTa9w91H+vPnXQj3KfIwZSUni3xdsH075NLZEbNDK7dpfMqzDge7Skxpten2rLXwU0hih9lsLDWXAA6mhruc3c+oORnLUNN1F8J3H5eX29pMlGDBsfUc8Yf7GJ/Tc03GuRZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtqBw0GTZz6JBT1;
	Tue,  4 Jun 2024 20:09:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BF22D140DD5;
	Tue,  4 Jun 2024 20:13:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 13:13:27 +0100
Date: Tue, 4 Jun 2024 13:13:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: fan <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <gregory.price@memverge.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan
 Ni <fan.ni@samsung.com>, <mst@redhat.com>
Subject: Re: [PATCH v7 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20240604131326.00005fe0@Huawei.com>
In-Reply-To: <20240604125428.00003a1d@Huawei.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
	<20240418232902.583744-10-fan.ni@samsung.com>
	<877cgkxzal.fsf@pond.sub.org>
	<Zivk37xBGPsL_yo5@debian>
	<87h6fkob0t.fsf@pond.sub.org>
	<ZjEnwPeoivsW8y5Z@debian>
	<20240501155812.00002ec3@Huawei.com>
	<87cyox9icl.fsf@pond.sub.org>
	<20240604125428.00003a1d@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 4 Jun 2024 12:54:28 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 04 Jun 2024 11:18:18 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
> > I finally got around to read this slowly.  Thank you, Fan and Jonathan!
> > 
> > I'm getting some "incomplete" vibes: "if we ever implement", "patches
> > for this on list", "we aren't emulating this yet at all", and ...  
> 
> Absolutely.  There is a bunch of stuff that we reject today but
> the interfaces allow you to specify it and align with the CXL specification
> Fabric Management API definition which is the spec used to control this
> stuff from a BMC etc.  If that doesn't work we have a hardware errata
> problem, so hopefully that is fairly stable.
> 
> I think I can publicly confirm there are some related errata in flight,
> seeing as we said we'd raise questions on some aspects in the kernel and
> QEMU series preceding this one (so no IP secrecy issues). These are as a
> result of this work from Fan, but we have carefully avoided implementing
> anything that 'may' change.
> 
> 
> > 
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> > 
> > [...]
> >   
> > > Only thing I'd add is that for now (because we don't need it for testing
> > > the kernel flows) is that this does not provide any way for external
> > > agents (e.g. our 'fabric manager' to find out what the state is - i.e.
> > > if the extents have been accepted by the host etc). That stuff is all
> > > defined by the spec, but not yet in the QMP interface.  At somepoint
> > > we may want to add that as a state query type interface.    
> > 
> > ... this, too.
> > 
> > In review of v5, I asked whether this interface needs to be stable.
> > 
> > "Not stable" doesn't mean we change an interface without thought.  It
> > merely means we can change it much, much faster, and with much less
> > overhead.
> > 
> > I understand you want it chiefly for CXL development.  Development aids
> > commonly don't need to be stable.  
> 
> Ok. If it makes sense to make this unstable for now I'm fine with that.
> I don't see why it would change beyond in backwards compatible fashion
> with new optional fields to cover future specification updates allowing
> for more information. However I've been wrong on such things before.
> 
> So I'm fine adding a patch on top of v8 marking them unstable for now.

Does this look correct?  Applied on top of the docs update patch just
posted in response to v8.  In my view neither is a blocker on Michael
Tsirkin sending a pull request but +CC so he is aware of discussion.

[PATCH] hw/cxl/events: Mark cxl-add-dynamic-capacity and cxl-release-dynamic-capcity unstable

Markus suggested that we make the unstable. I don't expect these
interfaces to change because of their tight coupling to the Compute
Express Link (CXL) Specification, Revision 3.1 Fabric Management API
definitions which can only be extended in backwards compatible way.
However, there seems little disadvantage in taking a cautious path
for now and marking them as unstable interfaces.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index a38622a0d1..bdfac67c47 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -453,6 +453,10 @@
 # @extents: The "Extent List" field as defined in Compute Express Link
 #     (CXL) Specification, Revision 3.1, Table 7-70.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-add-dynamic-capacity',
@@ -462,7 +466,8 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
 
 ##
@@ -527,6 +532,10 @@
 # @extents: The "Extent List" field as defined in Compute Express
 #     Link (CXL) Specification, Revision 3.1, Table 7-71.
 #
+# Features:
+#
+# @unstable: For now this command is subject to change.
+#
 # Since : 9.1
 ##
 { 'command': 'cxl-release-dynamic-capacity',
@@ -538,5 +547,6 @@
             'region': 'uint8',
             '*tag': 'str',
             'extents': [ 'CxlDynamicCapacityExtent' ]
-           }
+           },
+  'features': [ 'unstable' ]
 }
-- 
2.39.2


