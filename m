Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172782576E
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789072749; cv=none; b=dIdfGhi72G4kLKdHI0G3smi1hymZT0D4F91+l2PIQ8D1q4jM/FqX7tYI/H5hWPi0bYj1eM/OqPBf0PFoyY0QuWUlKCw/lRP8TZpvyEKaWaqUrBGFUyDgyXNO8pUNnvQfbl/hA1dmVTYfLhmAPVE1n+DsRqhSFr0p12381eOuxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789072749; c=relaxed/simple;
	bh=elybVScutjwqqlfL9sbH+0tjWkI3RUJFiEQ9NTHC4/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nF/aZuVuawpy/Bs+Fc+niNL2234gtDjSplroNd5aIXJN5gJWU2Gb28oCjoKIr0ZOgQsqMfszk0EOm0r9xqpyNZyOHiXM0vfK5AneFBOYwGc7YKf8qC8LPcWagaBHTGSOEcttd3iu5Y7jyxmBiJZWM6qWS638wy8mgofuD+5JbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFgGQz8X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFgGQz8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789072746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W89XY5ddO1xTrfK0PtXVl0trd8MW28EGY2w+oiM4Azk=;
	b=FFgGQz8X/wrAJN6xiKH4f9Q6OWIyb4b7PJMhXhB3RDJSSWnMRXfVVHDRzL9JZPamJWWh36
	cP1XMfoSKgbd/xVtgvkyVNLA/IRVQmJcHqUVu5iM+o0v8TiwYDTcguj+Yrofti+naqAT9Z
	kF8MB61n+137c8SL6/tpHDgtwE4Kapo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-PfjfOswTMEiOq0qcOWd0WA-1; Thu,
 10 Sep 2026 16:39:03 -0400
X-MC-Unique: PfjfOswTMEiOq0qcOWd0WA-1
X-Mimecast-MFC-AGG-ID: PfjfOswTMEiOq0qcOWd0WA_1789072742
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4E5118002AB;
	Thu, 10 Sep 2026 20:39:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C776B46E;
	Thu, 10 Sep 2026 20:38:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-cxl@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Lukas Straub <lukasstraub2@web.de>,
	Markus Armbruster <armbru@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	qemu-block@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 00/10] qapi: convert simple data struct/alternate intro sections
Date: Thu, 10 Sep 2026 16:38:46 -0400
Message-ID: <20260910203856.99003-1-jsnow@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: uw9chQaCYELEIwo_-Dojg2o2-eXgeMJboWWW4znzH5I_1789072742
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello, this work converts "simple" intro sections for data struct=0D
definitions (and one alternate) in the QAPI schema to use the new=0D
syntax. This is part of our ongoing effort to add the mythical=0D
"inliner" to our generated QMP documentation.=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
(This is about 25% of the remaining conversions.)=0D
=0D
"data struct" is another non-technical distinction that means a QAPI=0D
struct that is not used as a branch, argument definition, or the basis=0D
of another struct. In effect, it is only "data" and as a result, is=0D
not *currently* a candidate to be inlined into any other definition.=0D
=0D
Documentation that is to be "inlined"-- to be written into another=0D
definition's documentation-- needs to ensure that the documentation=0D
written in the "intro" segment is not crucial to understanding the=0D
behavior of the individual members. The "intro" does not get inlined,=0D
but the rest of the documentation does. These "data structs" as=0D
isolated in this series currently are not eligible to be inlined. As=0D
such, the precise distinction between intro and details for these=0D
definitions is not presently as crucial - however, these structs may=0D
become inlined in the future, so a closer eye is still warranted.=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series, you=0D
may wish to review what information is being counted as the "intro"=0D
(The indented paragraph) and keep in mind that in the future, this=0D
text may not be visible to the end-user reading our QMP documentation=0D
if this structure is utilized as the 'base' for another struct, used=0D
as the arguments for a command or event, or used as branch of a=0D
union. This series keeps it pretty simple, and every conversion herein=0D
is being codified as "the intro", i.e. "not crucial to understanding=0D
the behavior of the members of this struct".=0D
=0D
John Snow (10):=0D
  qapi: convert simple data struct intros for uefi.json=0D
  qapi: convert simple data struct intros for misc-arm.json=0D
  qapi: convert simple data struct intros for acpi.json=0D
  qapi: convert simple data struct intros for run-state.json=0D
  qapi: convert simple data struct intros for yank.json=0D
  qapi: convert simple data struct intros for cxl.json=0D
  qapi: convert simple data struct intros for virtio.json=0D
  qapi: convert simple data struct intros for machine.json=0D
  qapi: convert simple data struct intros for block-core.json=0D
  qapi: convert simple alternate intros for common.json=0D
=0D
 qapi/acpi.json       |  7 +++----=0D
 qapi/block-core.json | 37 ++++++++++++++++---------------------=0D
 qapi/common.json     |  7 +++----=0D
 qapi/cxl.json        |  7 +++----=0D
 qapi/machine.json    | 12 +++++-------=0D
 qapi/misc-arm.json   |  9 ++++-----=0D
 qapi/run-state.json  |  7 +++----=0D
 qapi/uefi.json       |  5 ++---=0D
 qapi/virtio.json     | 37 ++++++++++++++++---------------------=0D
 qapi/yank.json       | 10 ++++------=0D
 10 files changed, 59 insertions(+), 79 deletions(-)=0D
=0D
--=20=0D
2.55.0=0D
=0D

