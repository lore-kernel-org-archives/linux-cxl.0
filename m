Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D576391838
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538152; cv=none; b=MrsWcdOlrTPKl3XNJxsqKPB3uNBeCUlaIQdfffSPKifwBGzhpRneBrWO4Pgg2jHc8TDhZ2FkiNQdOoxu0IgN+uaix8pgoSZrcThd4PKchTrQgLMwxV3QMGv5eKJ1Peyr8/BmcxscM9GlPBiNBHjU1dqWqTFFN1BHIuJbdIDrLeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538152; c=relaxed/simple;
	bh=PE9Xm9YaJcVXYL6P8d7ga1shjgBHydXIAq6yxZMVaD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DI+GC+q8cemxcoSMYczBtTuZ1NDZ24Pssfpl3edp2y23/bUY7RJCNepu9rvg831r4zEPxC2YDglvx8bWHQ2BNSW6Cvm2ISfDF6nuqjsKm3LlODNnipO6BXjWCMJFlr6Je8tMONCXkV2MO5OB3L3x7bR2G1q4Krw1on0wnsuYKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIuMX1Vq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIuMX1Vq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774538149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vzpehDqYgCyCogpznJ1yRYvkvpNP6+3YYzUqRgqyluU=;
	b=HIuMX1VqhAHkE72CYeoVkSdXKpMuhl+zslj9tCeVO1DWib9V/vNRfuSnZtf2MaQ35ncHhb
	IyfC0H9047jwKHpCyPI3sjCSARyh/8tyo1wy8eKBvqZhFHo6TZ0Fw3KyZ9Mv49g2Y+k0jr
	DuLA8DmzCJJkC2oW0Muev5u75gs5/b0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-dVAnXoqzMDWhQysiOPlhcw-1; Thu,
 26 Mar 2026 11:15:46 -0400
X-MC-Unique: dVAnXoqzMDWhQysiOPlhcw-1
X-Mimecast-MFC-AGG-ID: dVAnXoqzMDWhQysiOPlhcw_1774538145
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEABB1956048;
	Thu, 26 Mar 2026 15:15:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 085F31955D84;
	Thu, 26 Mar 2026 15:15:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 952BA21E6937; Thu, 26 Mar 2026 16:15:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <anisa.su@samsung.com>,
  <berrange@redhat.com>,  <eblake@redhat.com>,
  <jonathan.cameron@huawei.com>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  <lizhijian@fujitsu.com>,  <mst@redhat.com>,
  <pbonzini@redhat.com>,  <gourry@gourry.net>,  <nifan.cxl@gmail.com>,
  <me@linux.beauty>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
In-Reply-To: <20260325184259.366-10-alireza.sanaee@huawei.com> (Alireza
	Sanaee's message of "Wed, 25 Mar 2026 18:42:57 +0000")
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
	<20260325184259.366-10-alireza.sanaee@huawei.com>
Date: Thu, 26 Mar 2026 16:15:40 +0100
Message-ID: <87mrzuei5f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: rpfbegNFT8SVP7xFBQMK_8v5T2XSV3oiyelsvt5wSQ8_1774538145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

I'm a near-complete CXL ignoramus, and beg your patience.

Alireza Sanaee <alireza.sanaee@huawei.com> writes:

> Add a small status query so orchestration layers can check whether a tagged
> extent is still pending, committed, or no longer present after a release
> request.

Why would they want to check?

What is a "release request"?

>
> Introduce the ExtentStatus QAPI struct and the
> cxl-release-dynamic-capacity-status command.
>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 81d6198ba0..53325ba530 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -636,3 +636,49 @@
>             },
>    'features': [ 'unstable' ]
>  }
> +
> +##
> +# @ExtentStatus:

Blank line here, please.

> +# This is an object that describes the status of an extent.
> +#
> +# @status:   String indicating the overall result, e.g. "success".

What are the possible values?  Are they defined in some spec?

> +# @message:  Human-readable description of the outcome.

Intended use?

> +#
> +# Since: 9.1

11.1 most likely.

> +##
> +{ 'struct': 'ExtentStatus',
> +      'data': { 'status': 'str', 'message': 'str' }
> +}
> +
> +##
> +# @cxl-release-dynamic-capacity-status:
> +#
> +# This commands checks if an extent tag has been released or not.

Use imperative mood to describe commands: "Check whether an extent tag
has been released."

> +#
> +# @path: path to the CXL Dynamic Capacity Device in the QOM tree.

We commonly call such members @qom-path.

> +#
> +# @host-id: The "Host ID" field as defined in Compute Express Link
> +#     (CXL) Specification, Revision 3.1, Table 7-71.
> +#
> +# @region: The "Region Number" field as defined in Compute Express
> +#     Link Specification, Revision 3.1, Table 7-71.  Valid range
> +#     is from 0-7.
> +#
> +# @tag: The "Tag" field as defined in Compute Express Link (CXL)
> +#     Specification, Revision 3.1, Table 7-71.

I guess the command interrogates something called "extent", and the
something is related to the CXL device at @path in the QOM tree.
Correct?

How is it related?  Is it a part of the device?

I further guess multiple extends can be so related, and @host-id,
@region, and @tag identify select the one we want to interrogate.
Correct?

> +#
> +# Features:
> +#
> +# @unstable: For now this command is subject to change.

The conventional language is "This command is experimental."

> +#
> +# Since: 9.1

11.1 most likely.

> +##
> +{ 'command': 'cxl-release-dynamic-capacity-status',
> +  'data': { 'path': 'str',
> +            'host-id': 'uint16',
> +            'region': 'uint8',
> +            'tag': 'str'
> +          },
> +  'features': [ 'unstable' ],
> +  'returns': 'ExtentStatus'

Swap these two lines, please.

> +}

