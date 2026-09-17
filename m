Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFC3CB54B
	for <linux-cxl@vger.kernel.org>; Thu, 17 Sep 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789674388; cv=none; b=uk4F5n2rslJi6o25K3FdafWvE06LgIxBssGX5lk5ckKha7I53p6nET3KuLZ6cllsSkAJP4iN7oUVzgubdlCVf+jjE25CXJzZ/RmWpkX3qpWdN1/oVLjQJKqMT4prupm4xBNjIRSYzzwEHvPj0kTaxey8RoHH0bpdSVEjerqNxx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789674388; c=relaxed/simple;
	bh=aQZLaGDR9AnylphMqWy318SjsUBAbbyWAp5uuioGLXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pNlgRLjhQ0r9qPZAJNuD2aqCFCHFCgTOlXoCxWHKRa4LHusr/JS38tyTWxgGEsw9Jg/70tmAHx5lnXr0Lw3Z3M55Ti0m3Fh/O707Huyo4WzB6PAZsgpnO+VROKqBesPpsJRicelJEttTiC8UaRD3xCnnACzH9iaCBaicGEKAZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFD9qutJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFD9qutJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789674385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5a9yXSDeIGHi/IyaT+sKCAVt/Ksq77ZmwHhs435xwFU=;
	b=XFD9qutJ+w6+bkZ4/mo+B+/jQlyllWSSiko0QGTtkWl5RQGtR/+1ExLwDXsfVGmJJL4lWF
	Iya9PDiuvoqMa4q7bVTHoYEGaLyxix89TPazmbCyxUrLF21G3S4Bio5fLXqqn5NNcm8bo0
	fsbk7xckLIRWtc05fkwcWDdbiZ0ASYI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-iQ2N5XSUOP-kFnZ2c4StUA-1; Thu,
 17 Sep 2026 15:46:22 -0400
X-MC-Unique: iQ2N5XSUOP-kFnZ2c4StUA-1
X-Mimecast-MFC-AGG-ID: iQ2N5XSUOP-kFnZ2c4StUA_1789674380
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9FF71944EBB;
	Thu, 17 Sep 2026 19:46:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 406BD19AC047;
	Thu, 17 Sep 2026 19:46:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Junjie Cao <junjie.cao@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-cxl@vger.kernel.org,
	Jason Wang <jasowangio@gmail.com>,
	Eric Blake <eblake@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Jonathan Cameron <jic23@kernel.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v5 0/7] qapi: convert remaining "simple" intro sections
Date: Thu, 17 Sep 2026 15:46:07 -0400
Message-ID: <20260917194614.549584-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: kv-0znuA6R3FsoL3xK8YHww7tRJpm3XcQvaIk7R7J0s_1789674380
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

v5:=0D
 - Make insert algorithm simpler=0D
 - Excise one case from patch 7/7, saving for a later series.=0D
v4:=0D
 - :(=0D
 - :( :(=0D
 - Fix 'Fix python typing issue with hotfix from below ...'=0D
v3:=0D
 - Fix python typing issue with hotfix from below ...=0D
 - Rebase on top of armbru/qapi-not-next=0D
v2:=0D
 - Fix stub insertion algorithm for some "TODO:" replacement cases=0D
=0D
Hello, this work converts the remaining "simple" intro sections in the=0D
QAPI schema to use the new syntax. This is part of our ongoing effort=0D
to add the mythical "inliner" to our generated QMP documentation.=0D
=0D
This batch covers structures that *are* likely to be inlined, and thus=0D
have introductory paragraphs that are quite likely to be omitted when=0D
the member documentation is copied into other contexts (e.g. as=0D
arguments for command documentation, or as members of a branch for=0D
commands that accept union arguments.)=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series, you=0D
may wish to review what information is being codified as the "intro"=0D
(The indented paragraph) and keep in mind that in the future, this=0D
text may not be visible to the end-user reading our QMP documentation=0D
if this structure is utilized as the 'base' for another struct, used=0D
as the arguments for a command or event, or used as branch of a=0D
union. This series keeps it pretty simple, and every conversion herein=0D
is being codified as "the intro", i.e. "not crucial to understanding=0D
the behavior of the members of this struct".=0D
=0D
This is the last of the brain-dead, simple conversions apart from any=0D
new cases that may have been merged during the development of this=0D
series. The remaining patches all convert or split longer paragraphs=0D
and require more scrutiny.=0D
=0D
We're almost back to reviewing actual code! Hang in there, everybody.=0D
=0D
John Snow (7):=0D
  qapi: convert remaining simple intros for block-export.json=0D
  qapi: convert remaining simple intros for cxl.json=0D
  qapi: convert remaining simple intros for machine.json=0D
  qapi: convert remaining simple intros for block-core.json=0D
  qapi/parser: fix intermediate "intro" detection=0D
  qapi: convert intro sections with "TODO" markers=0D
  qapi: convert intro sections followed by notes/examples=0D
=0D
 qapi/block-core.json   | 45 ++++++++++++++++++------------------------=0D
 qapi/block-export.json | 19 ++++++++----------=0D
 qapi/cxl.json          | 14 +++++--------=0D
 qapi/machine.json      | 10 +++-------=0D
 qapi/migration.json    | 25 +++++++++--------------=0D
 qapi/misc.json         |  3 +--=0D
 qapi/net.json          |  9 +++------=0D
 qapi/run-state.json    |  7 +++----=0D
 qapi/yank.json         |  5 +----=0D
 scripts/qapi/parser.py |  8 ++++++++=0D
 10 files changed, 60 insertions(+), 85 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

