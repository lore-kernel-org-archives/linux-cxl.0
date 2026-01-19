Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DF53596F7
	for <linux-cxl@vger.kernel.org>; Mon, 19 Jan 2026 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768824919; cv=none; b=SCR2kW/aE+ewkECYHrCpQ1FFKRnkRD8u4wBM6xLmsQ8EcxVqqFJwOB8LLlo/ylf8vOR9Ib73/Ux7SPWC9hexg1/pjwxDNiT16Hr6yNd2ia0/D3h2eLsUQQE0mvVvqh77+YejH3zMBVk48hk1JXAlgkOOHT2xTJItD6d8X7ArlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768824919; c=relaxed/simple;
	bh=bvxWCqw5fCKBDGAL+m+613DKVC5/XoM3Zg8lYMP/v7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RY8X5A6smTyChcdD7WUz+YjPinMWVeIIzjblR9H7VmV0IXPDWu4PxwO+/b9kbGAeBtrzH9M04feE3AlH2MPcVwp/ChsgZJnLIrkUSw5g3hgNXLUdm4eqCkT9nbl+eDrLuVnkO2AAQWUvlFpA+TkKHLjEGcsILU7aexGBup01lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAwvNmma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAwvNmma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768824917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvxWCqw5fCKBDGAL+m+613DKVC5/XoM3Zg8lYMP/v7s=;
	b=OAwvNmma1lvoKq0X3nmIUHI1HOEUJ+o+P+uCWtQePuYS3H3SmDqhHfycsxqso4h6AEa7NI
	V5RePCHVL8mM8bsWaoXQblTuJpSGsnhNw+9GQD5SFeYj2ieC9HQN81yGH4Iskg/CYc1Gk8
	252162cfSOs973j2FgUG5KHAaKDO6yE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ypbtPHDhNgW4cgTtBcG3lw-1; Mon,
 19 Jan 2026 07:15:15 -0500
X-MC-Unique: ypbtPHDhNgW4cgTtBcG3lw-1
X-Mimecast-MFC-AGG-ID: ypbtPHDhNgW4cgTtBcG3lw_1768824914
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 352F0180045C;
	Mon, 19 Jan 2026 12:15:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C84230001A7;
	Mon, 19 Jan 2026 12:15:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 9338421E692D; Mon, 19 Jan 2026 13:15:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tsirkin <mst@redhat.com>,  <qemu-devel@nongnu.org>,
  <shiju.jose@huawei.com>,  <armbru@redhat.com>,  <linuxarm@huawei.com>,
  <linux-cxl@vger.kernel.org>,  Ravi Shankar <venkataravis@micron.com>
Subject: Re: [PATCH qemu v4 0/5] cxl: r3.2 specification event updates.
In-Reply-To: <20260119111542.788389-1-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Mon, 19 Jan 2026 11:15:37 +0000")
References: <20260119111542.788389-1-Jonathan.Cameron@huawei.com>
Date: Mon, 19 Jan 2026 13:15:10 +0100
Message-ID: <87ikcxn6i9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Series
Acked-by: Markus Armbruster <armbru@redhat.com>

