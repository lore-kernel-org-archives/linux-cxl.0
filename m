Received: from a8-21.smtp-out.amazonses.com (a8-21.smtp-out.amazonses.com [54.240.8.21])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0402D23A6;
	Thu, 23 Apr 2026 23:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988274; cv=none; b=sqWSfyaUlZcDrqWQN0TlZvG1roN5IvV+DqOsbEkqvA/IW6xQ+ldxLmiT/8I8+Kon5TpTHOMyNLebsfVaHwOddXE078kEsqKaRCZl97zBekGXp3bQgeAjy4AvAL+9lLDlpt5oUwnfge7FuB4kTFW2qqqGp7WrDh7B20QnCF2xlpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988274; c=relaxed/simple;
	bh=/HvGF+yiVeXOsiwYAmEZlqwpUjxuZGoUDJ37IqEThgw=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=c7YPCNII0oa/HFxwlH9ENkhB5v+9bUW5hSh2rRRd3nD/fpmE9wvzpm9AVCUecbJnIis9x9BaOsYr3tHclLxQCwXUZBP4BmuMCVCb0dszUGpka6/OOYk/HC5lbLsq2Ebmj0R/9PGkDyvnxmELS4p1Cw5aWxV/0Ww9qnCegctmjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=j0sS4txj; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=aqkksNfs; arc=none smtp.client-ip=54.240.8.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="j0sS4txj";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="aqkksNfs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1776988272;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=/HvGF+yiVeXOsiwYAmEZlqwpUjxuZGoUDJ37IqEThgw=;
	b=j0sS4txjXKbebOHU71oovBYM65APJnXka3quzdBQPBL62XAZBoncv8taBT+yqC1+
	2rLl5ixSU0XOyzYWFgjQcOlSF4bELe1ePuf2fI92BEqqxQnlQ22Wz10AUHmE3venhLL
	ivKr0bUEVJFZr8Yi3p5MeXHpe5zG+7JGaKwU1S+U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1776988272;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=/HvGF+yiVeXOsiwYAmEZlqwpUjxuZGoUDJ37IqEThgw=;
	b=aqkksNfsdNlsQTIOkeRYwfL4zdxT5kYz42fzl1z/qv5mwN3zzTyhohDHHgpMPoQh
	gEiKiZPbDmzWDlBWUEFSFKZ6npSwvjIF1wBgc9pHrKqgtf/mw1lWHXoMfH+KMUIjEed
	ja0GXHtjHSCL6cSDaUaVqS7ucHanJBQi9sRwRYA4=
Subject: [RFC PATCH 0/4] cxl/extent: Enable and validate multi-extent DCDs
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Davidlohr_Bueso?= <dave@stgolabs.net>, 
	=?UTF-8?Q?Jonathan_Cameron?= <jonathan.cameron@huawei.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Alison_Schofield?= <alison.schofield@intel.com>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Ira_Weiny?= <ira.weiny@intel.com>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Fan_Ni?= <fan.ni@samsung.com>, 
	=?UTF-8?Q?Anisa_Su?= <anisa.su@samsung.com>, 
	=?UTF-8?Q?Shiju_Jose?= <shiju.jose@huawei.com>, 
	=?UTF-8?Q?Robert_Richter?= <rrichter@amd.com>
Cc: =?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>, 
	=?UTF-8?Q?dev=2Esrinivasulu=40?= =?UTF-8?Q?gmail=2Ecom?= <dev.srinivasulu@gmail.com>, 
	=?UTF-8?Q?arramesh=40micron=2Ecom?= <arramesh@micron.com>, 
	=?UTF-8?Q?ajayjoshi=40micron=2Ecom?= <ajayjoshi@micron.com>
Date: Thu, 23 Apr 2026 23:51:12 +0000
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20260423235108.3732424-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHc03wPAUxMlerVT8upYY6XegNaOA==
Thread-Topic: [RFC PATCH 0/4] cxl/extent: Enable and validate multi-extent
 DCDs
X-Wm-Sent-Timestamp: 1776988271
X-Original-Mailer: git-send-email 2.53.0
Message-ID: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.04.23-54.240.8.21

From: John Groves <john@groves.net>=0D=0A=0D=0AThis series fixes correctn=
ess issues in the DCD (Dynamic Capacity=0D=0ADevice) add-capacity pipelin=
e so that multi-tag allocations, sharable=0D=0ACDAT regions, and cross-pa=
rtition checks work end-to-end.=0D=0A=0D=0ABase=0D=0A----=0D=0A=0D=0AThe =
series applies on top of Anisa Su's DCD stack =E2=80=94 specifically the=0D=
=0Atip of famfs-v9-dcd on the 'anisa' remote=0D=0A(git@github.com:anisa-s=
u993/anisa-linux-kernel.git).  That stack is=0D=0Athe one posted to linux=
-cxl here:=0D=0A=0D=0A  https://lore.kernel.org/linux-cxl/adnWg-60uKmduTs=
h@gourry-fedora-PF4VCD3F/T/#t=0D=0A=0D=0AI started out commenting on prio=
r series, then started modifying it,=0D=0Abefore settling on this initial=
 approach of generalizing the=0D=0Afunctionality through additional patch=
es. I'm hoping the stake holders=0D=0Awill find this easy to follow - at =
least as easy to follow as something=0D=0Athis tedious and nuanced can be=
=2E=0D=0A=0D=0AAlso, as one of the authors of the DCD spec: Now I get why=
 this was hard=0D=0Ato follow and implement. The implementation is pretty=
 complicated.=0D=0A=0D=0ANote that this RFC builds happily, but I have no=
t tested it yet. This=0D=0Aexercise has been about fleshing out the full =
logic.=0D=0A=0D=0AThe patches=0D=0A-----------=0D=0A=0D=0A 1) cxl/extent:=
 Promote cxlr_dax->region_extent to an xarray=0D=0A=0D=0A    Infrastructu=
re only.  Replaces the single-slot region_extent=0D=0A    pointer on stru=
ct cxl_dax_region with an xarray keyed by an=0D=0A    allocator-assigned =
u32.  No behavior change; prepares storage for=0D=0A    multiple tagged a=
llocations per DAX-region shim.=0D=0A=0D=0A 2) cxl/extent: Fix DCD add-ca=
pacity: per-tag assembly, ordering, and=0D=0A    integrity=0D=0A=0D=0A   =
 Rewrites the add-capacity pipeline around the tag as the unit of=0D=0A  =
  allocation (not the More-chain).  Drops the DPA-contiguity reject,=0D=0A=
    assembles each tag group separately, stable-sorts by=0D=0A    shared_=
extn_seq, and adds cross-More-chain uniqueness,=0D=0A    sequence-integri=
ty, and alignment gates.  Lifts the single-slot=0D=0A    "already onlined=
" gate now that (1) is in place.=0D=0A=0D=0A 3) cxl/extent: Support exten=
ts in sharable CDAT regions=0D=0A=0D=0A    Drops the per-extent rejection=
 of shared_extn_seq !=3D 0 and=0D=0A    replaces it with a partition-awar=
e check driven by the DSMAS=0D=0A    SHAREABLE bit already exposed throug=
h cxl_dpa_partition.=0D=0A=0D=0A 4) cxl/extent: Reject tagged extents tha=
t span DC partitions=0D=0A=0D=0A    Adds a group-level check rejecting ta=
gged allocations whose=0D=0A    extents resolve to different DC partition=
s.  A single host-visible=0D=0A    allocation cannot meaningfully straddl=
e partitions whose CDAT=0D=0A    attributes disagree.=0D=0A=0D=0ASigned-o=
ff-by: John Groves <John@Groves.net>=0D=0A=0D=0AJohn Groves (4):=0D=0A  c=
xl/extent: Promote cxlr_dax->region_extent to an xarray=0D=0A  cxl/extent=
: Fix DCD add-capacity: per-tag assembly, ordering, and=0D=0A    integrit=
y=0D=0A  cxl/extent: Support extents in sharable CDAT regions=0D=0A  cxl/=
extent: Reject tagged extents that span DC partitions=0D=0A=0D=0A drivers=
/cxl/core/extent.c |  93 +++---=0D=0A drivers/cxl/core/mbox.c   | 628 +++=
++++++++++++++++++++++++++++-------=0D=0A drivers/cxl/core/region.c |   2=
 +=0D=0A drivers/cxl/cxl.h         |   9 +-=0D=0A include/cxl/event.h    =
   |   1 -=0D=0A 5 files changed, 584 insertions(+), 149 deletions(-)=0D=0A=
=0D=0A--=20=0D=0A2.53.0=0D=0A=0D=0A
